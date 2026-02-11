# Step by Step API

Backend para **Step by Step**, una plataforma de acompañamiento emocional para la creación de hábitos y rutinas.

## Características
* **Autenticación**: Registro e Inicio de sesión con JWT.
* **Rutinas y Hábitos**: Gestión completa de rutinas diarias y seguimiento de cumplimiento.
* **Comunidad**: Explorar rutinas públicas compartidas por otros usuarios.
* **Gamificación**: Evolución de mascota virtual basada en el progreso de hábitos.
* **Notificaciones**: Integración con FCM para recordatorios y suscripciones a canales.

## Requisitos Previos
* Python 3.10+
* MySQL 8.0+

## 📦 Instalación

1. **Clonar el repositorio**:
   ```bash
   git clone <url-del-repositorio>
   cd FastAPIProject
   ```

2. **Crear un entorno virtual**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # En Windows: venv\Scripts\activate
   ```

3. **Instalar dependencias**:
   ```bash
   pip install -r requirements.txt
   ```

## ⚙️ Configuración

1. **Base de Datos**:
   - Crea una base de datos en MySQL llamada `rutinas_test` (o el nombre que prefieras).
   - Importa el dump de la base de datos proporcionado:
     ```bash
     mysql -u tu_usuario -p rutinas_test < _localhost-2026_02_10_21_16_49-dump.sql
     ```

2. **Variables de Entorno**:
   Crea un archivo `.env` en la raíz del proyecto basándote en la configuración de `app/core/config.py`:
   ```env
   DATABASE_URL=mysql+aiomysql://usuario:password@localhost/rutinas_test
   SECRET_KEY=tu_clave_secreta_para_jwt
   ALGORITHM=HS256
   ACCESS_TOKEN_EXPIRE_MINUTES=30
   ```

## Ejecución

Para iniciar el servidor de desarrollo:
```bash
uvicorn app.main:app --reload
```

El servidor estará disponible en `http://127.0.0.1:8000`.

## 📖 Documentación de la API

Una vez que el servidor esté funcionando, puedes acceder a la documentación interactiva:
* **Swagger UI**: [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs)
* **ReDoc**: [http://127.0.0.1:8000/redoc](http://127.0.0.1:8000/redoc)

## 📁 Estructura del Proyecto
* `app/api`: Rutas de la API versionadas.
* `app/core`: Configuraciones centrales, seguridad y base de datos.
* `app/models`: Modelos de datos (SQLAlchemy).
* `app/schemas`: Esquemas de validación (Pydantic).
* `app/services`: Lógica de negocio y servicios externos.


## Usuarios para pruebas   
* usuario: hugo@test.com
* password: pass123
