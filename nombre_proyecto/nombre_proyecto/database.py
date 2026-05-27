dj_database_url = "sqlite:///C:/Users/polan/OneDrive/Documents/prog2026.1/Estructura_de_Datos/Select_ex/Backend_Proyect/bd_project.sql"
import os

DATABASES = {
    'default': dj_database_url.config(
        default=os.environ.get('DATABASE_URL'),
        conn_max_age=600
    )
}