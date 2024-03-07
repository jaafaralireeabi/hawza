from os import path
from django.http import JsonResponse
from .models import Lec,lecVideo
from django.shortcuts import render
from json import dumps

def index(request):
    data = Lec.objects.all() 
    return render(request,"pages/index.html",{"lec":data})

def resopn(request):
    data = list(Lec.objects.values("name"))
    
    return JsonResponse(data,safe=False)

def lec(request):
    pF = "templates/pages/"
    templates_names = []
    if path.isdir(pF+"lecs"):
        for n in Lec.objects.values_list("name",flat=True):
            templates_names.append(f"pages/lecs/{n}.html")
    return render(request,templates_names)