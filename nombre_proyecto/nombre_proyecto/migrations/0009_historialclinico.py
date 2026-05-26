from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('nombre_proyecto', '0008_caracterizacion_citologia_rectal_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='HistorialClinico',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('inicio_vida_sexual', models.CharField(blank=True, max_length=10)),
                ('edad_inicio_vida_sexual', models.CharField(blank=True, max_length=10)),
                ('tiene_pareja', models.CharField(blank=True, max_length=10)),
                ('pareja_sexual', models.CharField(blank=True, max_length=50)),
                ('numero_parejas', models.CharField(blank=True, max_length=10)),
                ('desea_tener_hijos', models.CharField(blank=True, max_length=20)),
                ('tiene_hijos', models.CharField(blank=True, max_length=10)),
                ('cantidad_hijos', models.CharField(blank=True, max_length=10)),
                ('fecha_citologia', models.CharField(blank=True, max_length=20)),
                ('citologia_tipo', models.JSONField(blank=True, default=list)),
                ('gestaciones', models.CharField(blank=True, max_length=10)),
                ('partos', models.CharField(blank=True, max_length=10)),
                ('cesareas', models.CharField(blank=True, max_length=10)),
                ('abortos', models.CharField(blank=True, max_length=10)),
                ('ectopicos', models.CharField(blank=True, max_length=10)),
                ('hijos_nacidos_vivos', models.CharField(blank=True, max_length=10)),
                ('hijos_nacidos_muertos', models.CharField(blank=True, max_length=10)),
                ('ha_usado_metodo', models.CharField(blank=True, max_length=10)),
                ('metodo_usado', models.CharField(blank=True, max_length=100)),
                ('experiencia_metodo', models.CharField(blank=True, max_length=50)),
                ('experiencia_observacion', models.TextField(blank=True)),
                ('metodos_utilizados', models.JSONField(blank=True, default=list)),
                ('usa_metodo_actual', models.CharField(blank=True, max_length=10)),
                ('metodo_actual', models.CharField(blank=True, max_length=100)),
                ('tiempo_metodo_actual', models.CharField(blank=True, max_length=100)),
                ('necesidades_orientacion', models.JSONField(blank=True, default=list)),
                ('otro_tema_orientacion', models.CharField(blank=True, max_length=255)),
                ('antecedentes_personales', models.JSONField(blank=True, default=dict)),
                ('otra_enfermedad', models.CharField(blank=True, max_length=255)),
                ('fecha_registro', models.DateTimeField(auto_now_add=True)),
                ('fecha_actualizacion', models.DateTimeField(auto_now=True)),
                ('usuario', models.OneToOneField(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='historial_clinico',
                    to='nombre_proyecto.usuarioexterno',
                )),
            ],
        ),
    ]
