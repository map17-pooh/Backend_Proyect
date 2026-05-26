from rest_framework import routers
from django.urls import path, include
from .views import (
    UsuarioExternoViewSet, AcudienteViewSet,
    RegisterAPIView, LoginAPIView, LoginInternoAdminAPIView,
    UsuarioInternoViewSet, AdministradorViewSet, EstadisticasAPIView,
    AsesoriaViewSet, PasswordResetRequestAPIView, PasswordResetConfirmAPIView,
    MiPerfilAPIView, CaracterizacionAPIView, HistorialClinicoAPIView,
    TokenRefreshAPIView,
)

router = routers.DefaultRouter()
router.register(r'usuarios', UsuarioExternoViewSet, basename='usuario')
router.register(r'acudientes', AcudienteViewSet, basename='acudiente')
router.register(r'internos', UsuarioInternoViewSet, basename='usuariointerno')
router.register(r'administradores', AdministradorViewSet, basename='administrador')
router.register(r'asesorias', AsesoriaViewSet, basename='asesoria')

urlpatterns = [
    path('register/', RegisterAPIView.as_view(), name='register'),
    path('login/', LoginAPIView.as_view(), name='login'),
    path('login-interno/', LoginInternoAdminAPIView.as_view(), name='login-interno'),
    path('estadisticas/', EstadisticasAPIView.as_view(), name='estadisticas'),
    path('password-reset/', PasswordResetRequestAPIView.as_view(), name='password-reset'),
    path('password-reset/confirm/', PasswordResetConfirmAPIView.as_view(), name='password-reset-confirm'),
    path('mi-perfil/', MiPerfilAPIView.as_view(), name='mi-perfil'),
    path('caracterizacion/', CaracterizacionAPIView.as_view(), name='caracterizacion-create'),
    path('caracterizacion/<int:user_id>/', CaracterizacionAPIView.as_view(), name='caracterizacion-detail'),
    path('historial-clinico/', HistorialClinicoAPIView.as_view(), name='historial-clinico-create'),
    path('historial-clinico/<int:user_id>/', HistorialClinicoAPIView.as_view(), name='historial-clinico-detail'),
    path('token/refresh/', TokenRefreshAPIView.as_view(), name='token-refresh'),
    path('', include(router.urls)),
]
