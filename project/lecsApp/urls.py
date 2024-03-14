import os
from django.urls import path,include
from . import views
from .models import Lec,lecVideo


urlpatterns = [
    path('',views.index,name='index'),
    path('respon',views.resopn,name='respon'),
    path('test',views.test,name='test'),
]
pF = "templates/pages/"
if os.path.isdir(pF+"lecs"):
    counter = 1
    for tn in Lec.objects.values_list("name",flat=True):
        urlpatterns.append(path(tn.replace(" ","_"),views.lec,name=f'lec{counter}'))
        counter += 1
