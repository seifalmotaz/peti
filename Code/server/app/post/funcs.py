from fastapi import HTTPException, status
from app.models import engine, User, Post, ObjectId

async def is_exist(id: ObjectId) -> Post:
    post = await engine.find_one(Post, Post.id == id)
    if not post:
        raise HTTPException(404)
    return post

async def is_owner(id: ObjectId, current_user: User) -> Post:
    post = await is_exist(id)
    if post.creator.owner != current_user:
        raise HTTPException(status.HTTP_403_FORBIDDEN)
    return post