from app.config import S3Client
from .InputSchema import *
from fastapi import APIRouter, Depends, UploadFile, File, status, Response
from app.config.depends import get_current_user
from .funcs import is_owner, is_exist
from app.pet.funcs import is_owner as is_owner_pet
from app.models import engine, User, Post, PostFunc, FileType, Like

router = APIRouter(prefix="")


@router.post('/create/image/')
async def image(post: PostCreate = Depends(PostCreate.as_form),  file: UploadFile = File(None), current_user: User = Depends(get_current_user)):
    pet = await is_owner_pet(post.creator_id, current_user)
    file_data = await S3Client().dict_upload(file)
    file_data['bgcolor'] =  post.color
    new_post = Post(
        creator=pet,
        file=file_data,
        location=current_user.location,
        file_type=FileType.IMAGE,
    )
    if post.caption:
        new_post.content = post.caption
    await engine.save(new_post)
    return Response(status_code=status.HTTP_201_CREATED)

@router.post('/create/video/')
async def video(post: PostCreate = Depends(PostCreate.as_form),  file: UploadFile = File(None), thumbinal: Optional[UploadFile] = File(None), current_user: User = Depends(get_current_user)):
    pet = await is_owner_pet(post.creator_id, current_user)
    file_data = await S3Client().dict_upload(file)
    file_data['thumbinal'], mimetype =  await S3Client().upload(thumbinal)
    file_data['bgcolor'] =  post.color
    new_post = Post(
        creator=pet,
        file=file_data,
        location=current_user.location,
        file_type=FileType.VIDEO,
    )
    if post.caption:
        new_post.content = post.caption
    await engine.save(new_post)
    return Response(status_code=status.HTTP_201_CREATED)


@router.get('/read/')
async def read(id: ObjectId, current_user: User = Depends(get_current_user)):
    post = await is_exist(id)
    post_data = await PostFunc.get_classic_data(post)
    return post_data


@router.delete('/delete/')
async def delete(id: ObjectId, current_user: User = Depends(get_current_user)):
    post = await is_owner(id, current_user)
    likes = await engine.find(Like, Like.liked == post.id)
    for k in likes:
        await engine.delete(k)
    await engine.delete(post)
    return 'done'
