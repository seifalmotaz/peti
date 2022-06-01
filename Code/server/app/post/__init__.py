from fastapi import APIRouter
from .crud import router as crudRouter
from .external import router as externalRouter
from .comment import router as commentRouter

router = APIRouter(
    prefix="/post",
    tags=['Posts']
)

router.include_router(crudRouter)
router.include_router(externalRouter)
router.include_router(commentRouter)
