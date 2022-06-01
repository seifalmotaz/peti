from .funcs import is_exist
from typing import List
from app.models import engine, Comment, ObjectId, User, CommentFunc
from fastapi import APIRouter, Depends
from app.config.depends import get_current_user

router = APIRouter(prefix="/comment")

@router.post('/create/', response_model=Comment)
async def create(postId: ObjectId, content: str, current_user: User = Depends(get_current_user)):
    post = await is_exist(postId)
    new_comment = Comment(
        content=content,
        commented=post,
        commenter=current_user,
    )
    post.comments = post.comments + 1
    await engine.save_all([new_comment, post])
    return new_comment

@router.get('/list/')
async def list(postId: ObjectId, page: int = 0, current_user: User = Depends(get_current_user)):
    comments = await engine.find(Comment, Comment.commented == postId, skip=(page * 13), limit=13, sort=Comment.created_at.desc())
    list_comments = [await CommentFunc.get_classic_data(x) for x in comments]
    return list_comments