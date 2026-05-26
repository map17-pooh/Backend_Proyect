from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('nombre_proyecto', '0012_alter_acudiente_id_alter_administrador_id_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='usuarioexterno',
            name='refresh_token',
            field=models.CharField(blank=True, max_length=64, null=True, unique=True),
        ),
        migrations.AddField(
            model_name='usuarioexterno',
            name='refresh_token_expires_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='usuariointerno',
            name='refresh_token',
            field=models.CharField(blank=True, max_length=64, null=True, unique=True),
        ),
        migrations.AddField(
            model_name='usuariointerno',
            name='refresh_token_expires_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='administrador',
            name='refresh_token',
            field=models.CharField(blank=True, max_length=64, null=True, unique=True),
        ),
        migrations.AddField(
            model_name='administrador',
            name='refresh_token_expires_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
