from fastapi import APIRouter, Depends, HTTPException
from typing import Annotated
from fastapi import Query,Path,Body
from ..images.model.image_model import ImageModel

router = APIRouter(
    prefix="/images",
    tags=["images"],
    dependencies=[],
    responses={404: {"description": "Not found"}},
)
list_image =[
    ImageModel(image_id="1", image_name="Cat.png"),
    ImageModel(image_id="2", image_name="Dog.png"),
]

@router.get("/images/")
async def read_images(q: Annotated[str | None, Query(max_length=50)] = None):
    return list_image

@router.get("/images/{image_id}")
async def read_images_by_id(image_id: Annotated[str, Path(title="The ID of the image to get")]):
    image = [i for i in list_image if i.image_id == image_id]
    if len(image) == 1:
        return image[0]
    raise HTTPException(status_code=404, detail="Image not found")

@router.post("/images")
async def create_image(image: Annotated[ImageModel, Body(embed=True)]):
    list_image.append(image)
    return image

@router.put("/images")
async def update_image(image: Annotated[ImageModel, Body(embed=True)]):
    idx = [i.image_id for i in list_image].index(image.image_id)
    if idx >= 0:
        update_image = list_image[idx]
        update_image.image_name = image.image_name
        list_image[idx] = update_image
        return update_image
    raise HTTPException(status_code=404, detail="Image not found")

@router.delete("/images/{image_id}")
async def delete_image(image_id: Annotated[str, Path(title="The ID of the image to delete")]):
    for i in list_image:
        if i.image_id == image_id:
            list_image.remove(i)
            break
    pass