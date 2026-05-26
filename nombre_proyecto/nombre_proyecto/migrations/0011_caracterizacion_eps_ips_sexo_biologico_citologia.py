from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('nombre_proyecto', '0010_alter_acudiente_id_alter_administrador_id_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='caracterizacion',
            name='eps_ips',
            field=models.CharField(blank=True, max_length=200),
        ),
        migrations.AddField(
            model_name='caracterizacion',
            name='sexo_biologico',
            field=models.CharField(blank=True, max_length=20),
        ),
        migrations.AddField(
            model_name='caracterizacion',
            name='metodo_anticonceptivo_pareja',
            field=models.CharField(blank=True, max_length=200),
        ),
        migrations.AddField(
            model_name='caracterizacion',
            name='ha_realizado_citologia',
            field=models.BooleanField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='caracterizacion',
            name='metodo_anticonceptivo',
            field=models.CharField(blank=True, max_length=200),
        ),
    ]
