from fastapi import APIRouter
from .crud import router as crudRouter
from .external import router as externalRouter

router = APIRouter(
    prefix="/pet",
    tags=['Pets']
)

router.include_router(crudRouter)
router.include_router(externalRouter)
