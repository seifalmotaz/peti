from app.config import S3Client
from app.models.Post import Like, Post
from .InputSchema import *
from fastapi import APIRouter, Depends, UploadFile, File
from app.config.depends import get_current_user
from app.models import engine, User, Pet, ObjectId, Follower, Request
from .funcs import is_owner, is_exist

router = APIRouter(prefix="")


@router.post('/create/')
async def create(data: PetCreate = Depends(PetCreate.as_form), file: UploadFile = File(None), current_user: User = Depends(get_current_user)):
    file_url, mimetype =await  S3Client().upload(file)
    pet = Pet(
        avatar=file_url,
        name=data.name,
        birthday=data.birthday,
        gender=data.gender,
        type=data.type,
        want_marraige=data.want_marraige,
        owner=current_user,
    )
    if data.breed:
        pet.breed = data.breed
    await engine.save(pet)
    return 'done'


@router.get('/read/')
async def read(id: ObjectId, current_user: User = Depends(get_current_user)):
    pet = await is_exist(id)
    is_following: bool
    is_follow_exist = await engine.find_one(Follower, Follower.follower == current_user.id, Follower.following == pet.id)
    if is_follow_exist:
        is_following = True
    else:
        is_following = False
    
    data = {
        'pet': pet.dict(exclude={'id', 'owner'}),
        'user': pet.owner.dict(exclude= {'access_token', 'password', 'email', 'phone', 'id', 'location'}),
        'is_following': is_following,
    }

    if pet.owner.id == current_user.id:
        requests_count = await engine.count(Request, Request.receiver == pet.id)
        data['requests_count'] = requests_count
    
    data['pet']['id'] = str(pet.id)
    data['user']['id'] = str(pet.owner.id)
    return data


@router.put('/update/', response_model=Pet, response_model_exclude={'owner'})
async def update(id: ObjectId, data: PetUpdate, current_user: User = Depends(get_current_user)):
    pet = await is_owner(id, current_user)
    perData = data.dict(exclude_unset=True)
    for name, value in perData.items():
        setattr(pet, name, value)
    await engine.save(pet)
    return pet

@router.put('/update/avatar/', response_model=Pet, response_model_exclude={'owner'})
async def update(id: ObjectId, file: UploadFile = File(None), current_user: User = Depends(get_current_user)):
    pet = await is_owner(id, current_user)
    url, mimetype = await S3Client().upload(file)
    pet.avatar = url
    await engine.save(pet)
    return pet 


@router.delete('/delete/')
async def delete(id: ObjectId, current_user: User = Depends(get_current_user)):
    pet = await is_owner(id, current_user)
    posts = await engine.find(Post, Post.creator == pet.id)
    for p in posts:
        likes = await engine.find(Like, Like.liked == p.id)
        for k in likes:
            await engine.delete(k)
        await engine.delete(p)
    await engine.delete(pet)
    return 'done'
