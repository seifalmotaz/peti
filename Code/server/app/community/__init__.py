from fastapi import APIRouter
from .crud import router as crudRouter

router = APIRouter(
    prefix="/community",
    tags=['Community']
)

router.include_router(crudRouter)
