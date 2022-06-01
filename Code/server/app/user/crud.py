from .InputSchema import *
from fastapi import APIRouter, HTTPException, status, Depends, UploadFile, File
from passlib.hash import pbkdf2_sha256
from app.config.depends import get_current_user
from app.models import Location, engine, User, query
from odmantic import ObjectId
from app.config import S3Client

router = APIRouter(prefix="")

@router.get('/is_exist/')
async def is_exist(email: Optional[str]):
    is_user = await engine.find_one(User, User.email == email)
    if is_user:
        if is_user.email == email:
            raise HTTPException(status.HTTP_406_NOT_ACCEPTABLE, detail='email')
    return 'ok'

@router.post('/create/', response_model=User, response_model_exclude={'password'})
async def create(user: User):
    is_user = await engine.find_one(User, query.or_(User.email == user.email, User.phone == user.phone))
    if is_user:
        if is_user.email == user.email:
            raise HTTPException(status.HTTP_406_NOT_ACCEPTABLE, detail='email')
    user.avatar = 'https://peti.ams3.digitaloceanspaces.com/default.jpg'
    user.password = pbkdf2_sha256.hash(user.password)
    user.location.owner = user.id
    await engine.save(user)
    return user

@router.get('/read/', response_model=User, response_model_exclude={'access_token'})
async def read(id: ObjectId, current_user: User = Depends(get_current_user)):
    user = await engine.find_one(User, User.id == id)
    if not user:
        raise HTTPException(status.HTTP_404_NOT_FOUND, detail='User not found')
    return user

@router.put('/update/avatar/', response_model=User)
async def update(file: UploadFile = File(None), current_user: User = Depends(get_current_user)):
    url, mimetype = await S3Client().upload(file)
    current_user.avatar = url
    await engine.save(current_user)
    return current_user 

@router.put('/update/', response_model=User)
async def update(data: UserUpdate, current_user: User = Depends(get_current_user)):
    user = data.dict(exclude_unset=True)
    for name, value in user.items():
        setattr(current_user, name, value)
    await engine.save(current_user)
    return current_user

@router.put('/update/location/', response_model=Location)
async def update(data: LocationUpdate, current_user: User = Depends(get_current_user)):
    location = await engine.find_one(Location, query.and_(Location.id == current_user.location.id))
    loacation_new_data = data.dict(exclude_unset=True)
    for name, value in loacation_new_data.items():
        setattr(location, name, value)
    location.owner = current_user.id
    await engine.save(location)
    return location


@router.delete('/delete/')
async def delete(current_user: User = Depends(get_current_user)):
    await engine.delete(current_user)
    return 'done'
