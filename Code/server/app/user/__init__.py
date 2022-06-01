from fastapi import APIRouter
from .crud import router as crudRouter
from .auth import router as authRouter
from .external import router as externalRouter

router = APIRouter(
    prefix="/user",
    tags=['Users']
)

router.include_router(crudRouter)
router.include_router(authRouter)
router.include_router(externalRouter)
