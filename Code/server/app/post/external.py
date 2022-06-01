from .funcs import is_exist
from app.models import engine, ObjectId, User, Post, PostFunc, Like, query, Location, FileType
from fastapi import APIRouter, Depends
from app.config.depends import get_current_user

router = APIRouter(prefix="")


@router.get('/watch/gallary/')
async def watch(page: int = 0, current_user: User = Depends(get_current_user)):
    if current_user.location:
        locations = await engine.find(Location, Location.city == current_user.location.city)
        locations_ids = [location.id for location in locations]
        posts = await engine.find(Post, query.and_(query.in_(Post.location, locations_ids), Post.file_type == FileType.IMAGE), skip=(page * 21), limit=21, sort=Post.created_at.desc())
    else:
        posts = await engine.find(Post, Post.file_type == FileType.IMAGE, skip=(page * 21), limit=21, sort=Post.created_at.desc())
    
    posts_data = [await PostFunc.get_classic_data(post, current_user.id) for post in posts]
    if len(posts_data) < 21:
        more_posts = await engine.find(Post, query.and_(query.not_in(Post.id, [post.id for post in posts]), Post.file_type == FileType.IMAGE), skip=(page * 21), limit=21, sort=Post.created_at.desc())
        posts_data.extend([await PostFunc.get_classic_data(post, current_user.id) for post in more_posts])
    return posts_data

@router.get('/watch/tv/')
async def watch(page: int = 0, current_user: User = Depends(get_current_user)):
    if current_user.location:
        locations = await engine.find(Location, Location.city == current_user.location.city)
        locations_ids = [location.id for location in locations]
        posts = await engine.find(Post, query.and_(query.in_(Post.location, locations_ids), Post.file_type == FileType.VIDEO), skip=(page * 21), limit=21, sort=Post.created_at.desc())
    else:
        posts = await engine.find(Post, Post.file_type == FileType.VIDEO, skip=(page * 21), limit=21, sort=Post.created_at.desc())
    
    posts_data = [await PostFunc.get_classic_data(post, current_user.id) for post in posts]
    if len(posts_data) < 21:
        more_posts = await engine.find(Post, query.and_(query.not_in(Post.id, [post.id for post in posts]), Post.file_type == FileType.VIDEO), skip=(page * 21), limit=21, sort=Post.created_at.desc())
        posts_data.extend([await PostFunc.get_classic_data(post, current_user.id) for post in more_posts])
    return posts_data


@router.post('/like/')
async def like(id: ObjectId, current_user: User = Depends(get_current_user)):
    post = await is_exist(id)
    isLiked = await engine\
        .find_one(Like, query.and_(Like.liked == id, Like.liker == current_user.id))
    if isLiked:
        post.likes = post.likes - 1
        post.creator.likes = post.creator.likes - 1
        await engine.delete(isLiked)
        await engine.save(post)
        return False

    like = Like(liked=post, liker=current_user)
    post.likes = post.likes + 1
    post.creator.likes = post.creator.likes + 1
    await engine.save_all([like, post])
    return True
