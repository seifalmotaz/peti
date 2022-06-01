from motor.motor_asyncio import AsyncIOMotorClient
from odmantic import AIOEngine

# TODO: change on deploy
# client = AsyncIOMotorClient("mongodb://root:root@mongo:27017/")
# engine = AIOEngine(database="PetiDB", motor_client=client)
engine = AIOEngine(database="PetiDB")