from rest_framework import serializers
from django.contrib.auth.hashers import make_password
from .models import UsuarioExterno, Acudiente, UsuarioInterno, Administrador, Asesoria, Caracterizacion, HistorialClinico


class HistorialClinicoSerializer(serializers.ModelSerializer):
    class Meta:
        model = HistorialClinico
        fields = '__all__'
        read_only_fields = ['fecha_registro', 'fecha_actualizacion']


class AsesoriaSerializer(serializers.ModelSerializer):
    class Meta:
        model = Asesoria
        fields = ['id', 'usuario', 'fecha', 'hora', 'motivo', 'estado', 'created_at']
        read_only_fields = ['created_at']


class CaracterizacionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Caracterizacion
        fields = '__all__'
        read_only_fields = ['fecha_registro', 'fecha_actualizacion']


class AcudienteSerializer(serializers.ModelSerializer):
    class Meta:
        model = Acudiente
        fields = ['id', 'nombre', 'telefono', 'parentesco']


class UsuarioExternoSerializer(serializers.ModelSerializer):
    acudiente = AcudienteSerializer(required=False, allow_null=True)

    class Meta:
        model = UsuarioExterno
        fields = [
            'id', 'nombre_completo', 'tipo_documento', 'numero_documento',
            'fecha_nacimiento', 'telefono', 'direccion', 'email', 'password',
            'es_menor_14', 'acudiente', 'auth_token', 'auth_token_expires_at',
            'refresh_token', 'created_at'
        ]
        extra_kwargs = {
            'password': {'write_only': True},
            'auth_token': {'read_only': True},
            'auth_token_expires_at': {'read_only': True},
            'refresh_token': {'read_only': True},
        }

    def create(self, validated_data):
        acudiente_data = validated_data.pop('acudiente', None)
        # Hash password before saving
        if 'password' in validated_data:
            validated_data['password'] = make_password(validated_data['password'])

        usuario = UsuarioExterno.objects.create(**validated_data)
        usuario.generate_token()

        if acudiente_data:
            Acudiente.objects.create(usuario=usuario, **acudiente_data)

        return usuario

    def update(self, instance, validated_data):
        acudiente_data = validated_data.pop('acudiente', None)
        password = validated_data.get('password', None)
        if password:
            instance.password = make_password(password)
            validated_data.pop('password')

        for attr, value in validated_data.items():
            setattr(instance, attr, value)
        instance.save()

        if acudiente_data is not None:
            # update or create acudiente
            Acudiente.objects.update_or_create(usuario=instance, defaults=acudiente_data)

        return instance


class UsuarioInternoSerializer(serializers.ModelSerializer):

    class Meta:
        model = UsuarioInterno
        fields = ['id', 'nombre_completo', 'puesto', 'email', 'password', 'auth_token', 'auth_token_expires_at', 'refresh_token', 'created_at']
        extra_kwargs = {
            'password': {'write_only': True},
            'auth_token': {'read_only': True},
            'auth_token_expires_at': {'read_only': True},
            'refresh_token': {'read_only': True},
        }

    def create(self, validated_data):
        from .models import UsuarioInterno
        if 'password' in validated_data:
            from django.contrib.auth.hashers import make_password
            validated_data['password'] = make_password(validated_data['password'])
        usuario = UsuarioInterno.objects.create(**validated_data)
        usuario.generate_token()
        return usuario


class AdministradorSerializer(serializers.ModelSerializer):
    class Meta:
        model = Administrador
        fields = ['id', 'nombre_completo', 'nivel', 'email', 'password', 'auth_token', 'auth_token_expires_at', 'refresh_token', 'created_at']
        extra_kwargs = {
            'password': {'write_only': True},
            'auth_token': {'read_only': True},
            'auth_token_expires_at': {'read_only': True},
            'refresh_token': {'read_only': True},
        }

    def create(self, validated_data):
        from .models import Administrador
        if 'password' in validated_data:
            from django.contrib.auth.hashers import make_password
            validated_data['password'] = make_password(validated_data['password'])
        admin = Administrador.objects.create(**validated_data)
        admin.generate_token()
        return admin
