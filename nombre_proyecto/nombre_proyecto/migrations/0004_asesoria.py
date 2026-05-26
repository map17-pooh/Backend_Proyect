from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('nombre_proyecto', '0003_create_interno_administrador'),
    ]

    operations = [
        migrations.CreateModel(
            name='Asesoria',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fecha', models.DateField()),
                ('hora', models.CharField(max_length=10)),
                ('motivo', models.TextField(blank=True)),
                ('estado', models.CharField(
                    choices=[
                        ('pendiente', 'Pendiente'),
                        ('confirmada', 'Confirmada'),
                        ('cancelada', 'Cancelada'),
                        ('completada', 'Completada'),
                    ],
                    default='pendiente',
                    max_length=20,
                )),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('usuario', models.ForeignKey(
                    on_delete=django.db.models.deletion.CASCADE,
                    related_name='asesorias',
                    to='nombre_proyecto.usuarioexterno',
                )),
            ],
        ),
    ]
