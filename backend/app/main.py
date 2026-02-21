from fastapi import FastAPI, Request, HTTPException, status, Depends
from fastapi.responses import JSONResponse
from datetime import datetime
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy import text
from app.core.database import get_db, SessionLocal
from app.api.v1 import auth, rutinas, comunidad, notificaciones, usuarios
from app.models import Usuario, Plan
from jose import jwt
from app.core.config import settings

app = FastAPI(
    title="Rutina step by step",
    description="""
API Backend para **Step by Step**, una plataforma de acompañamiento emocional para la creación de hábitos.

### Funcionalidades:
* **Autenticación**: Registro e Inicio de sesión con JWT.
* **Rutinas y Hábitos**: Gestión completa de rutinas diarias y seguimiento de cumplimiento.
* **Comunidad**: Explorar rutinas públicas compartidas por otros usuarios.
* **Gamificación**: Evolución de mascota virtual basada en el progreso de hábitos.
* **Notificaciones**: Integración con FCM para recordatorios y suscripciones a canales.

---
*Desarrollado para el equipo de Step by Step.*
""",
    version="1.0.0",
    contact={
        "name": "Soporte Step by Step",
        "url": "https://github.com/step-by-step",
    },
    license_info={
        "name": "MIT License",
    },
)

# Configuración de CORS
from fastapi.middleware.cors import CORSMiddleware

origins = ["*"]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.middleware("http")
async def trial_restriction_middleware(request: Request, call_next):
    path = request.url.path
    method = request.method
    
    is_critical_path = (path.startswith("/rutinas") or path.startswith("/ia")) and method in ["POST", "PATCH", "PUT"]
    
    if is_critical_path:
        auth_header = request.headers.get("Authorization")
        if auth_header and auth_header.startswith("Bearer "):
            token = auth_header.split(" ")[1]
            try:
                payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])
                user_id = payload.get("sub")
                
                async with SessionLocal() as db:
                    query = text("""
                        SELECT u.*, p.nombre as plan_nombre 
                        FROM usuarios u 
                        JOIN planes p ON u.plan_id = p.id 
                        WHERE u.id = :user_id
                    """)
                    result = await db.execute(query, {"user_id": user_id})
                    user = result.mappings().first()
                    
                    if user and user["plan_nombre"] in ["Free", "Gratuito"]:
                        if user["fecha_fin_trial"] and user["fecha_fin_trial"] < datetime.now():
                            return JSONResponse(
                                status_code=status.HTTP_402_PAYMENT_REQUIRED,
                                content={"detail": "Trial expired. Payment required."}
                            )
            except Exception:
                pass
                
    response = await call_next(request)
    return response

@app.exception_handler(Exception)
async def global_exception_handler(request: Request, exc: Exception):
    return JSONResponse(
        status_code=500,
        content={"message": "Internal Server Error", "detail": str(exc)},
    )

@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException):
    return JSONResponse(
        status_code=exc.status_code,
        content={"detail": exc.detail},
    )

# Registro de routers
app.include_router(auth.router)
app.include_router(rutinas.router, prefix="/v1")
app.include_router(comunidad.router, prefix="/v1")
# app.include_router(notificaciones.router, prefix="/v1")
app.include_router(usuarios.router, prefix="/v1")

@app.get("/")
async def root():
    return {"message": "Welcome to Step by Step API"}
