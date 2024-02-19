from django.http import JsonResponse
from django.shortcuts import render
from django.core.serializers import serialize
from .models import Lec
import json

def index(request):
    lec = Lec.objects.all()
    return render(request,'pages/index.html',{'lec':lec})
def respon(request):
    data = Lec.objects.values("name")
    return JsonResponse({"data":list(data)})
def lec(request):
    return render(request,["ADAA"])