from .funcs import is_exist
from typing import List, Optional
from app.models import engine, User, Follower, ObjectId, query, Pet, Post, PostFunc
from fastapi import APIRouter, Depends, HTTPException, status
from app.config.depends import get_current_user

router = APIRouter(prefix="")


@router.get('/owned/', response_model=List[Pet], response_model_exclude={'owner': {'access_token', 'password', 'email', 'phone'}})
async def owned(id: Optional[ObjectId] = None, current_user: User = Depends(get_current_user)):
    if id:
        pets = await engine.find(Pet, Pet.owner == id)
    else:
        pets = await engine.find(Pet, Pet.owner == current_user.id)
    return pets


@router.get('/follow/')
async def follow(id: ObjectId, current_user: User = Depends(get_current_user)):
    pet = await is_exist(id)
    if pet.owner == current_user:
        raise HTTPException(status.HTTP_405_METHOD_NOT_ALLOWED)
    isFollowing = await engine\
        .find_one(Follower, query.and_(Follower.following == pet.id, Follower.follower == current_user.id))
    if isFollowing:
        pet.followers = pet.followers - 1
        await engine.delete(isFollowing)
        await engine.save(pet)
        return False

    follow = Follower(following=pet, follower=current_user)
    pet.followers = pet.followers + 1
    await engine.save_all([follow])
    return True

@router.get('/posts/')
async def posts(id: ObjectId, page: int = 0, current_user: User = Depends(get_current_user)):
    posts = await engine.find(Post, Post.creator == id, skip=(page * 13), limit=13, sort=Post.created_at.desc())
    posts_data = [await PostFunc.get_classic_data(post, current_user.id) for post in posts]
    return posts_data
