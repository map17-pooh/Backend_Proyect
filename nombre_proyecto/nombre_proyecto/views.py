import secrets
from django.contrib.auth.hashers import check_password
from django.utils import timezone
from datetime import timedelta
from rest_framework import viewsets, permissions, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import BasePermission
from .models import (UsuarioExterno, Acudiente, UsuarioInterno, Administrador,
                     Asesoria, Caracterizacion, HistorialClinico,
                     ACCESS_TOKEN_MINUTES, REFRESH_TOKEN_DAYS)
from .serializers import (
    UsuarioExternoSerializer, AcudienteSerializer,
    UsuarioInternoSerializer, AdministradorSerializer, AsesoriaSerializer,
    CaracterizacionSerializer, HistorialClinicoSerializer,
)


def _resolve_token(request):
    token = request.headers.get('Authorization', '').replace('Token ', '').strip()
    if not token:
        return None, None
    for Model in (UsuarioInterno, Administrador, UsuarioExterno):
        try:
            user = Model.objects.get(auth_token=token)
            if user.token_is_valid():
                return user, Model.__name__
        except Model.DoesNotExist:
            continue
    return None, None


class IsInternalUser(BasePermission):
    """Permite acceso solo a UsuarioInterno y Administrador con token válido."""
    def has_permission(self, request, view):
        user, model_name = _resolve_token(request)
        return model_name in ('UsuarioInterno', 'Administrador')


class IsAdministrador(BasePermission):
    """Permite acceso solo a Administrador con token válido."""
    def has_permission(self, request, view):
        user, model_name = _resolve_token(request)
        return model_name == 'Administrador'


class IsAuthenticatedToken(BasePermission):
    """Permite acceso a cualquier usuario con token válido."""
    def has_permission(self, request, view):
        user, model_name = _resolve_token(request)
        return user is not None


class UsuarioExternoViewSet(viewsets.ModelViewSet):
    queryset = UsuarioExterno.objects.all().order_by('-created_at')
    serializer_class = UsuarioExternoSerializer

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        return [IsInternalUser()]


class RegisterAPIView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        try:
            print("DATA RECIBIDA:")
            print(request.data)

            serializer = UsuarioExternoSerializer(data=request.data)

            if serializer.is_valid():
                usuario = serializer.save()

                print("USUARIO CREADO")

                data = UsuarioExternoSerializer(usuario).data

                return Response(data, status=status.HTTP_201_CREATED)

            print("ERRORES SERIALIZER:")
            print(serializer.errors)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            import traceback

            print("ERROR TOTAL:")
            print(str(e))

            traceback.print_exc()

            return Response(
                {"error": str(e)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )


class LoginAPIView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        email = request.data.get('email')
        password = request.data.get('password')
        if not email or not password:
            return Response({'detail': 'Email y contraseña son requeridos.'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            usuario = UsuarioExterno.objects.get(email=email)
        except UsuarioExterno.DoesNotExist:
            return Response({'detail': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)

        if not check_password(password, usuario.password):
            return Response({'detail': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)

        usuario.generate_token()

        data = UsuarioExternoSerializer(usuario).data
        return Response(data, status=status.HTTP_200_OK)


class LoginInternoAdminAPIView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        email = request.data.get('email', '').strip()
        password = request.data.get('password', '')
        if not email or not password:
            return Response({'detail': 'Email y contraseña son requeridos.'}, status=status.HTTP_400_BAD_REQUEST)

        try:
            usuario = UsuarioInterno.objects.get(email=email)
            if not check_password(password, usuario.password):
                return Response({'detail': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)
            usuario.generate_token()
            data = UsuarioInternoSerializer(usuario).data
            data['tipo'] = 'Interno'
            return Response(data, status=status.HTTP_200_OK)
        except UsuarioInterno.DoesNotExist:
            pass

        try:
            admin = Administrador.objects.get(email=email)
            if not check_password(password, admin.password):
                return Response({'detail': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)
            admin.generate_token()
            data = AdministradorSerializer(admin).data
            data['tipo'] = 'Administrador'
            return Response(data, status=status.HTTP_200_OK)
        except Administrador.DoesNotExist:
            pass

        return Response({'detail': 'Credenciales inválidas.'}, status=status.HTTP_401_UNAUTHORIZED)


class TokenRefreshAPIView(APIView):
    """Renueva el access token usando el refresh token (sliding expiration)."""
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        refresh_token = request.data.get('refresh_token', '').strip()
        if not refresh_token:
            return Response({'detail': 'Refresh token requerido.'}, status=status.HTTP_400_BAD_REQUEST)

        for Model in (UsuarioExterno, UsuarioInterno, Administrador):
            try:
                user = Model.objects.get(refresh_token=refresh_token)
                if not user.refresh_is_valid():
                    return Response({'detail': 'Refresh token expirado. Inicie sesión nuevamente.'},
                                    status=status.HTTP_401_UNAUTHORIZED)
                # Generar nuevo access token y rotar refresh token (sliding)
                user.auth_token = secrets.token_hex(20)
                user.auth_token_expires_at = timezone.now() + timedelta(minutes=ACCESS_TOKEN_MINUTES)
                user.refresh_token = secrets.token_hex(32)
                user.refresh_token_expires_at = timezone.now() + timedelta(days=REFRESH_TOKEN_DAYS)
                user.save(update_fields=[
                    'auth_token', 'auth_token_expires_at',
                    'refresh_token', 'refresh_token_expires_at',
                ])
                return Response({
                    'auth_token': user.auth_token,
                    'auth_token_expires_at': user.auth_token_expires_at.isoformat(),
                    'refresh_token': user.refresh_token,
                }, status=status.HTTP_200_OK)
            except Model.DoesNotExist:
                continue

        return Response({'detail': 'Refresh token inválido.'}, status=status.HTTP_401_UNAUTHORIZED)


class AcudienteViewSet(viewsets.ModelViewSet):
    queryset = Acudiente.objects.all()
    serializer_class = AcudienteSerializer
    permission_classes = [IsAuthenticatedToken]


class UsuarioInternoViewSet(viewsets.ModelViewSet):
    queryset = UsuarioInterno.objects.all().order_by('-created_at')
    serializer_class = UsuarioInternoSerializer

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        return [IsAdministrador()]


class PasswordResetRequestAPIView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        email = request.data.get('email', '').strip()
        if not email:
            return Response({'detail': 'Email requerido.'}, status=status.HTTP_400_BAD_REQUEST)

        for Model in (UsuarioExterno, UsuarioInterno, Administrador):
            try:
                user = Model.objects.get(email=email)
                user.generate_token()
                return Response(
                    {'detail': 'Se ha enviado el token de recuperación.', 'token': user.auth_token},
                    status=status.HTTP_200_OK,
                )
            except Model.DoesNotExist:
                continue

        return Response({'detail': 'No existe una cuenta con ese correo.'}, status=status.HTTP_404_NOT_FOUND)


class PasswordResetConfirmAPIView(APIView):
    permission_classes = [permissions.AllowAny]

    def post(self, request):
        token = request.data.get('token', '').strip()
        new_password = request.data.get('new_password', '')
        if not token or not new_password:
            return Response({'detail': 'Token y nueva contraseña son requeridos.'}, status=status.HTTP_400_BAD_REQUEST)
        if len(new_password) < 6:
            return Response({'detail': 'La contraseña debe tener al menos 6 caracteres.'}, status=status.HTTP_400_BAD_REQUEST)

        from django.contrib.auth.hashers import make_password
        for Model in (UsuarioExterno, UsuarioInterno, Administrador):
            try:
                user = Model.objects.get(auth_token=token)
                if not user.token_is_valid():
                    return Response({'detail': 'El token ha expirado. Solicita uno nuevo.'}, status=status.HTTP_400_BAD_REQUEST)
                user.password = make_password(new_password)
                user.auth_token = None
                user.auth_token_expires_at = None
                user.save(update_fields=['password', 'auth_token', 'auth_token_expires_at'])
                return Response({'detail': 'Contraseña actualizada correctamente.'}, status=status.HTTP_200_OK)
            except Model.DoesNotExist:
                continue

        return Response({'detail': 'Token inválido.'}, status=status.HTTP_400_BAD_REQUEST)


class AsesoriaViewSet(viewsets.ModelViewSet):
    serializer_class = AsesoriaSerializer
    permission_classes = [IsAuthenticatedToken]

    def get_queryset(self):
        user, model_name = _resolve_token(self.request)
        if model_name in ('UsuarioInterno', 'Administrador'):
            return Asesoria.objects.all().order_by('-fecha')
        if model_name == 'UsuarioExterno':
            return Asesoria.objects.filter(usuario=user).order_by('-fecha')
        return Asesoria.objects.none()


class EstadisticasAPIView(APIView):
    permission_classes = [IsInternalUser]

    def get(self, request):
        data = {
            'usuarios_externos': UsuarioExterno.objects.count(),
            'usuarios_internos': UsuarioInterno.objects.count(),
            'administradores': Administrador.objects.count(),
            'acudientes': Acudiente.objects.count(),
        }
        return Response(data, status=status.HTTP_200_OK)


class AdministradorViewSet(viewsets.ModelViewSet):
    queryset = Administrador.objects.all().order_by('-created_at')
    serializer_class = AdministradorSerializer

    def get_permissions(self):
        if self.action == 'create':
            return [permissions.AllowAny()]
        return [IsAdministrador()]


class MiPerfilAPIView(APIView):
    """Retorna el perfil del UsuarioExterno autenticado."""
    permission_classes = [IsAuthenticatedToken]

    def get(self, request):
        user, model_name = _resolve_token(request)
        if model_name != 'UsuarioExterno':
            return Response({'detail': 'Solo disponible para usuarios externos.'}, status=status.HTTP_403_FORBIDDEN)
        return Response(UsuarioExternoSerializer(user).data, status=status.HTTP_200_OK)


class CaracterizacionAPIView(APIView):
    permission_classes = [IsAuthenticatedToken]

    def get(self, request, user_id=None):
        if user_id is None:
            return Response({'detail': 'user_id requerido.'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            caract = Caracterizacion.objects.get(usuario_id=user_id)
            return Response(CaracterizacionSerializer(caract).data, status=status.HTTP_200_OK)
        except Caracterizacion.DoesNotExist:
            return Response({}, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = CaracterizacionSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request, user_id=None):
        if user_id is None:
            return Response({'detail': 'user_id requerido.'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            caract = Caracterizacion.objects.get(usuario_id=user_id)
        except Caracterizacion.DoesNotExist:
            return Response({'detail': 'No encontrado.'}, status=status.HTTP_404_NOT_FOUND)
        serializer = CaracterizacionSerializer(caract, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


class HistorialClinicoAPIView(APIView):
    permission_classes = [IsAuthenticatedToken]

    def get(self, request, user_id=None):
        if user_id is None:
            return Response({'detail': 'user_id requerido.'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            historial = HistorialClinico.objects.get(usuario_id=user_id)
            return Response(HistorialClinicoSerializer(historial).data, status=status.HTTP_200_OK)
        except HistorialClinico.DoesNotExist:
            return Response({}, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = HistorialClinicoSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request, user_id=None):
        if user_id is None:
            return Response({'detail': 'user_id requerido.'}, status=status.HTTP_400_BAD_REQUEST)
        try:
            historial = HistorialClinico.objects.get(usuario_id=user_id)
        except HistorialClinico.DoesNotExist:
            return Response({'detail': 'No encontrado.'}, status=status.HTTP_404_NOT_FOUND)
        serializer = HistorialClinicoSerializer(historial, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
