from fastapi import APIRouter
from .crud import router as crudRouter

router = APIRouter(
    prefix="/request",
    tags=['Request']
)

router.include_router(crudRouter)