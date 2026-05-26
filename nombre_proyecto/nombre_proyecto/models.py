import secrets
from datetime import timedelta

from django.db import models
from django.utils import timezone


ACCESS_TOKEN_MINUTES = 15
REFRESH_TOKEN_DAYS = 7


class UsuarioExterno(models.Model):
    nombre_completo = models.CharField(max_length=255)
    tipo_documento = models.CharField(max_length=100, blank=True)
    numero_documento = models.CharField(max_length=100, blank=True)
    fecha_nacimiento = models.DateField(null=True, blank=True)
    telefono = models.CharField(max_length=50, blank=True)
    direccion = models.CharField(max_length=255, blank=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    es_menor_14 = models.BooleanField(default=False)
    auth_token = models.CharField(max_length=40, blank=True, null=True, unique=True)
    auth_token_expires_at = models.DateTimeField(null=True, blank=True)
    refresh_token = models.CharField(max_length=64, blank=True, null=True, unique=True)
    refresh_token_expires_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nombre_completo} <{self.email}>"

    def generate_token(self):
        self.auth_token = secrets.token_hex(20)
        self.auth_token_expires_at = timezone.now() + timedelta(minutes=ACCESS_TOKEN_MINUTES)
        self.refresh_token = secrets.token_hex(32)
        self.refresh_token_expires_at = timezone.now() + timedelta(days=REFRESH_TOKEN_DAYS)
        self.save(update_fields=['auth_token', 'auth_token_expires_at', 'refresh_token', 'refresh_token_expires_at'])

    def token_is_valid(self):
        return self.auth_token and self.auth_token_expires_at and self.auth_token_expires_at > timezone.now()

    def refresh_is_valid(self):
        return self.refresh_token and self.refresh_token_expires_at and self.refresh_token_expires_at > timezone.now()


class Acudiente(models.Model):
    usuario = models.OneToOneField(UsuarioExterno, related_name='acudiente', on_delete=models.CASCADE)
    nombre = models.CharField(max_length=255)
    telefono = models.CharField(max_length=50)
    parentesco = models.CharField(max_length=100, blank=True)

    def __str__(self):
        return f"Acudiente de {self.usuario.nombre_completo}: {self.nombre}"


class Diagnostico(models.Model):
    diagnostico = models.CharField(max_length=255)

    def __str__(self):
        return self.diagnostico


class UsuarioInterno(models.Model):
    nombre_completo = models.CharField(max_length=255)
    puesto = models.CharField(max_length=150, blank=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    auth_token = models.CharField(max_length=40, blank=True, null=True, unique=True)
    auth_token_expires_at = models.DateTimeField(null=True, blank=True)
    refresh_token = models.CharField(max_length=64, blank=True, null=True, unique=True)
    refresh_token_expires_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nombre_completo} <{self.email}>"

    def generate_token(self):
        self.auth_token = secrets.token_hex(20)
        self.auth_token_expires_at = timezone.now() + timedelta(minutes=ACCESS_TOKEN_MINUTES)
        self.refresh_token = secrets.token_hex(32)
        self.refresh_token_expires_at = timezone.now() + timedelta(days=REFRESH_TOKEN_DAYS)
        self.save(update_fields=['auth_token', 'auth_token_expires_at', 'refresh_token', 'refresh_token_expires_at'])

    def token_is_valid(self):
        return self.auth_token and self.auth_token_expires_at and self.auth_token_expires_at > timezone.now()

    def refresh_is_valid(self):
        return self.refresh_token and self.refresh_token_expires_at and self.refresh_token_expires_at > timezone.now()


class Asesoria(models.Model):
    ESTADO_CHOICES = [
        ('pendiente', 'Pendiente'),
        ('confirmada', 'Confirmada'),
        ('cancelada', 'Cancelada'),
        ('completada', 'Completada'),
    ]
    usuario = models.ForeignKey(UsuarioExterno, on_delete=models.CASCADE, related_name='asesorias')
    fecha = models.DateField()
    hora = models.CharField(max_length=10)
    motivo = models.TextField(blank=True)
    estado = models.CharField(max_length=20, choices=ESTADO_CHOICES, default='pendiente')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Asesoría {self.usuario.nombre_completo} - {self.fecha} {self.hora}"


class Caracterizacion(models.Model):
    usuario = models.OneToOneField(
        'UsuarioExterno', on_delete=models.CASCADE, related_name='caracterizacion'
    )
    # Datos de afiliación
    eps_ips = models.CharField(max_length=200, blank=True)
    # Sexo biológico e identidad de género (campos separados)
    sexo_biologico = models.CharField(max_length=20, blank=True)  # Hombre / Mujer
    sexo = models.CharField(max_length=100, blank=True)  # identidad de género
    identidad_otro = models.CharField(max_length=100, blank=True)
    # Socioeconómica
    estado_civil = models.CharField(max_length=100, blank=True)
    estrato = models.CharField(max_length=10, blank=True)
    ocupacion = models.CharField(max_length=150, blank=True)
    # Educación
    nivel_educativo = models.CharField(max_length=100, blank=True)
    institucion_educativa = models.CharField(max_length=255, blank=True)
    # Ubicación
    zona_residencia = models.CharField(max_length=50, blank=True)
    municipio = models.CharField(max_length=100, blank=True)
    # Salud reproductiva — femenino
    num_embarazos = models.PositiveSmallIntegerField(null=True, blank=True)
    num_partos = models.PositiveSmallIntegerField(null=True, blank=True)
    num_cesareas = models.PositiveSmallIntegerField(null=True, blank=True)
    num_abortos = models.PositiveSmallIntegerField(null=True, blank=True)
    usa_anticonceptivo = models.BooleanField(null=True, blank=True)
    metodo_anticonceptivo = models.CharField(max_length=200, blank=True)
    metodo_anticonceptivo_pareja = models.CharField(max_length=200, blank=True)
    ha_realizado_citologia = models.BooleanField(null=True, blank=True)
    fecha_ultima_citologia = models.DateField(null=True, blank=True)
    en_gestacion = models.BooleanField(null=True, blank=True)
    en_lactancia = models.BooleanField(null=True, blank=True)
    # Familia
    tiene_hijos = models.BooleanField(null=True, blank=True)
    numero_hijos = models.PositiveSmallIntegerField(null=True, blank=True)
    edades_hijos = models.CharField(max_length=255, blank=True)
    # Convivencia / red de apoyo
    vive_solo = models.BooleanField(null=True, blank=True)
    red_apoyo = models.TextField(blank=True)
    # Adulto mayor (≥60)
    dificultad_movilidad = models.BooleanField(null=True, blank=True)
    caidas_ultimo_anio = models.PositiveSmallIntegerField(null=True, blank=True)
    polifarmacia = models.BooleanField(null=True, blank=True)
    # Estilos de vida (condicionales por edad)
    vida_sexual_activa = models.BooleanField(null=True, blank=True)
    num_parejas_actuales = models.PositiveSmallIntegerField(null=True, blank=True)
    num_parejas_ultimo_anio = models.PositiveSmallIntegerField(null=True, blank=True)
    metodo_proteccion = models.CharField(max_length=20, blank=True)
    prueba_ets = models.BooleanField(null=True, blank=True)
    tiene_pareja = models.BooleanField(null=True, blank=True)
    pareja_sexual_es = models.CharField(max_length=50, blank=True)
    citologia_vaginal = models.BooleanField(default=False)
    citologia_rectal = models.BooleanField(default=False)
    citologia_vph = models.BooleanField(default=False)
    consume_alcohol = models.CharField(max_length=50, blank=True)
    consume_tabaco = models.CharField(max_length=50, blank=True)
    # Metadata
    fecha_registro = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Caracterización de {self.usuario.nombre_completo}"


class HistorialClinico(models.Model):
    usuario = models.OneToOneField(
        'UsuarioExterno', on_delete=models.CASCADE, related_name='historial_clinico'
    )
    # Caracterización Sexual y Reproductiva
    inicio_vida_sexual = models.CharField(max_length=10, blank=True)
    edad_inicio_vida_sexual = models.CharField(max_length=10, blank=True)
    tiene_pareja = models.CharField(max_length=10, blank=True)
    pareja_sexual = models.CharField(max_length=50, blank=True)
    numero_parejas = models.CharField(max_length=10, blank=True)
    desea_tener_hijos = models.CharField(max_length=20, blank=True)
    tiene_hijos = models.CharField(max_length=10, blank=True)
    cantidad_hijos = models.CharField(max_length=10, blank=True)
    fecha_citologia = models.CharField(max_length=20, blank=True)
    citologia_tipo = models.JSONField(default=list, blank=True)
    gestaciones = models.CharField(max_length=10, blank=True)
    partos = models.CharField(max_length=10, blank=True)
    cesareas = models.CharField(max_length=10, blank=True)
    abortos = models.CharField(max_length=10, blank=True)
    ectopicos = models.CharField(max_length=10, blank=True)
    hijos_nacidos_vivos = models.CharField(max_length=10, blank=True)
    hijos_nacidos_muertos = models.CharField(max_length=10, blank=True)
    # Antecedentes en Anticoncepción
    ha_usado_metodo = models.CharField(max_length=10, blank=True)
    metodo_usado = models.CharField(max_length=100, blank=True)
    experiencia_metodo = models.CharField(max_length=50, blank=True)
    experiencia_observacion = models.TextField(blank=True)
    metodos_utilizados = models.JSONField(default=list, blank=True)
    usa_metodo_actual = models.CharField(max_length=10, blank=True)
    metodo_actual = models.CharField(max_length=100, blank=True)
    tiempo_metodo_actual = models.CharField(max_length=100, blank=True)
    # Necesidad de Orientación
    necesidades_orientacion = models.JSONField(default=list, blank=True)
    otro_tema_orientacion = models.CharField(max_length=255, blank=True)
    # Antecedentes Personales (Criterios OMS)
    antecedentes_personales = models.JSONField(default=dict, blank=True)
    otra_enfermedad = models.CharField(max_length=255, blank=True)
    # Metadata
    fecha_registro = models.DateTimeField(auto_now_add=True)
    fecha_actualizacion = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Historial Clínico de {self.usuario.nombre_completo}"


class Administrador(models.Model):
    nombre_completo = models.CharField(max_length=255)
    nivel = models.CharField(max_length=100, blank=True)
    email = models.EmailField(unique=True)
    password = models.CharField(max_length=128)
    auth_token = models.CharField(max_length=40, blank=True, null=True, unique=True)
    auth_token_expires_at = models.DateTimeField(null=True, blank=True)
    refresh_token = models.CharField(max_length=64, blank=True, null=True, unique=True)
    refresh_token_expires_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Admin: {self.nombre_completo} <{self.email}>"

    def generate_token(self):
        self.auth_token = secrets.token_hex(20)
        self.auth_token_expires_at = timezone.now() + timedelta(minutes=ACCESS_TOKEN_MINUTES)
        self.refresh_token = secrets.token_hex(32)
        self.refresh_token_expires_at = timezone.now() + timedelta(days=REFRESH_TOKEN_DAYS)
        self.save(update_fields=['auth_token', 'auth_token_expires_at', 'refresh_token', 'refresh_token_expires_at'])

    def token_is_valid(self):
        return self.auth_token and self.auth_token_expires_at and self.auth_token_expires_at > timezone.now()

    def refresh_is_valid(self):
        return self.refresh_token and self.refresh_token_expires_at and self.refresh_token_expires_at > timezone.now()
