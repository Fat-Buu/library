from pydantic import BaseModel

class ImageModel(BaseModel):
    image_id:str
    image_name:str