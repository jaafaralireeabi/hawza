# Create your models here.
from typing import Any
from django.db import models
from os import mkdir,path,remove,renames
from glob import glob
from shutil import rmtree
from django.dispatch import receiver
from django.db.models.signals import pre_delete,pre_save


# def removeFolder(pF:str):
#     rmtree(pF)
# def clearFolder(pF:str):
#     print(pF)
#     files = glob(f"{pF}/*")
#     print(files)
#     for f in files:
#         remove(f)
# def createFolder(pathF:str,folderName:str):
#     mkdir(pathF+folderName)
# def createFile(pathF:str,fileName:str,content:str=""):
#     open(pathF+fileName, "x")
#     f = open(pathF+fileName,"w")
#     f.write(content)


class Lec(models.Model):
    name = models.CharField(max_length=50)
    image = models.ImageField(upload_to="images/%y/%m/%d",default="images/defaultLec.png",blank=None)
    
    # def __init__(self, *args: Any, **kwargs: Any) -> None:
    #     super().__init__(*args, **kwargs)
    #     pF = "templates/pages/"
    #     print(self.image)
    #     #clear folder
    #     clearFolder(pF+"lecs")
        

    #     content ="""{%load static%}
    # {%block content%}
    #     <!DOCTYPE html>
    #         <html lang="en">
    #             <head>
    #                 <meta charset="UTF-8">
    #                 <meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Document</title>    
    #                 <link rel="stylesheet" href="{% static 'css/lecStyle.css' %}">
    #                 <link rel="stylesheet" href="{% static 'fontawesome/all.css' %}">
    #                 <link rel="stylesheet" href="{% static 'fontawesome/all.min.css' %}">
    #             </head>
    #             <body>
    #                 <div class="con">
    #                     <div class="landing">
    #                         <div class="overlay"></div>
    #                         <div class="lecsTitle">
    #                             <h1>السيرة</h1>
    #                         </div>
    #                     </div>
    #                 </div>
    #                 <static src="lec.js"></static>
    #             </body>
    #             </html>
    # {%endblock content%}"""
    #     # create htmlDocs files and folder
    #     if not path.isdir(pF+"lecs"):
    #         createFolder(pF,"lecs")
    #     for n in Lec.objects.values_list("name",flat=True):
    #         createFile(pF+"lecs/",n+".html",content)
    def __str__(self):
        return "محاضرات: "+self.name
    class Meta:
        verbose_name = 'اقسام المحاضرات'


class lecVideo(models.Model):
    catgs = [
    ]
    if Lec.objects.all().exists():
        for n in Lec.objects.values_list("name",flat=True):
            catgs.append((n,n))
    videoUrl = models.FileField(upload_to="videos/%y/%m/%d")
    catgory = models.CharField(max_length=100,choices=catgs,default=[])
    class Meta:
        verbose_name = 'فيديوات المحاضرات'


@receiver(pre_save,sender=lecVideo)
def setVideoInLec(sender,instances,**kwargs):
    return 0
