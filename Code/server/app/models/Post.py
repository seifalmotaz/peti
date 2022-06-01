from datetime import datetime
from enum import Enum
from typing import Optional
from .engine import engine
from . import Pet, User, Location
from odmantic import Model, Reference, Field

class FileType(str, Enum):
    VIDEO = "video"
    IMAGE = "image"

class Post(Model):
    file: Optional[dict]
    content: Optional[str]
    file_type: Optional[FileType]
    creator: Pet = Reference()
    location: Location = Reference()
    likes: int = 0
    comments: int = 0
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        collection = 'posts'
        parse_doc_with_default_factories = True

class Like(Model):
    liked: Post = Reference()
    liker: User = Reference()
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        collection = 'likes'
        parse_doc_with_default_factories = True

class Comment(Model):
    content: str
    commented: Post = Reference()
    commenter: User = Reference()
    created_at: datetime = Field(default_factory=datetime.utcnow)

    class Config:
        collection = 'comments'
        parse_doc_with_default_factories = True

class PostFunc():
    async def get_classic_data(post: Post, id):
        is_exist = await engine.find_one(Like, Like.liker == id, Like.liked == post.id)
        if is_exist:
            is_liked = True
        else:
            is_liked = False
        data = post.dict(exclude={'id', 'creator', 'location'})
        data["id"] = str(post.id)
        data["creator"] = post.creator.dict(include={'avatar', 'name', 'gender'})
        data["creator"]["id"] = str(post.creator.id)
        data["creator"]["owner_id"] = str(post.creator.owner.id)
        data["location"] = post.location.dict(exclude={'id', 'owner'})
        data["location"]["id"] = str(post.location.id)
        data["is_liked"] = is_liked
        return data

class CommentFunc():
    async def get_classic_data(comment: Comment):
        data = comment.dict(include={'commenter': {
                'avatar',
                'first_name',
                'last_name',
            }})
        data['content'] = comment.content
        data['created_at'] = comment.created_at
        return data