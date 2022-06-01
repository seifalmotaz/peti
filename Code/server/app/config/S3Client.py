from fastapi import UploadFile, File, HTTPException
import boto3, datetime, uuid, mimetypes

object_storage_config = {
    'region_name': 'ams3',
    'endpoint_url': 'https://ams3.digitaloceanspaces.com',
    'aws_access_key_id': 'GRTOPXYX22PF2QLQ3ZM3',
    'aws_secret_access_key': 'hZdNztp5vepatGBDOUhMFAtKHqjy84XRJ+kpsqA0MjM'
}

# object_storage_config = {
#     'region_name': 'ams3',
#     'endpoint_url': 'http://192.168.1.19:9000',
#     'aws_access_key_id': 'minioadmin',
#     'aws_secret_access_key': 'minioadmin'
# }


class S3Client:
    def __init__(self) -> None:
        self.client = boto3.client('s3', **object_storage_config)

    async def upload(self, file: UploadFile = File(None)):
        # pre
        now = datetime.datetime.now()
        # file metadata
        filename = uuid.uuid1().hex
        mimetype = mimetypes.guess_type(file.filename)[0]
        filename = filename + "." + mimetype.split('/')[1]
        # file path config
        filepath = f'{mimetype.split("/")[0]}s/{now.year}/{now.month}/{filename}'
        # upload file to the space
        try: self.client.upload_fileobj(file.file, 'peti', filepath, ExtraArgs={"ACL": "public-read", "ContentType": mimetype})
        except: HTTPException(500)

        return f"https://peti.ams3.digitaloceanspaces.com/{filepath}", mimetype
        # return f"http://192.168.1.19:5000/static/{filepath}", mimetype

    async def dict_upload(self, file: UploadFile = File(None)):
        url, mimetype = await  self.upload(file=file)
        return {
            'url': url,
            'mimetype': mimetype,
        }
