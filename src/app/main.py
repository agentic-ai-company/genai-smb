# src/app/main.py
import logging

from fastapi import FastAPI

from .config import settings

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = FastAPI(
    title=settings.app_name,
    version=settings.version,
    docs_url="/docs" if settings.debug else None,
)


@app.get("/health")
async def health_check():
    return {"status": "ok", "environment": settings.environment}


@app.get("/")
async def root():
    logger.info("Root endpoint called")
    return {"message": "Hello, World!", "app": settings.app_name}
