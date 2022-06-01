import datetime
from fastapi import APIRouter, Depends, File
from app.models import engine, User
from app.config.depends import get_current_user

router = APIRouter(prefix="")

@router.post('/update/last_login/')
async def update_last_login(current_user: User = Depends(get_current_user)):
    current_user.last_login = datetime.datetime.utcnow()
    await engine.save(current_user)
    return {
        'version': '1.5.4',
        'important': True,
    }
