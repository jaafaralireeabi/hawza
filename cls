[1mdiff --git a/project/db.sqlite3 b/project/db.sqlite3[m
[1mindex a692a76..fe977a2 100644[m
Binary files a/project/db.sqlite3 and b/project/db.sqlite3 differ
[1mdiff --git a/project/lecsApp/__pycache__/models.cpython-312.pyc b/project/lecsApp/__pycache__/models.cpython-312.pyc[m
[1mindex 5806f7b..dea9652 100644[m
Binary files a/project/lecsApp/__pycache__/models.cpython-312.pyc and b/project/lecsApp/__pycache__/models.cpython-312.pyc differ
[1mdiff --git a/project/lecsApp/__pycache__/urls.cpython-312.pyc b/project/lecsApp/__pycache__/urls.cpython-312.pyc[m
[1mindex 507e2ba..a0afe59 100644[m
Binary files a/project/lecsApp/__pycache__/urls.cpython-312.pyc and b/project/lecsApp/__pycache__/urls.cpython-312.pyc differ
[1mdiff --git a/project/lecsApp/__pycache__/views.cpython-312.pyc b/project/lecsApp/__pycache__/views.cpython-312.pyc[m
[1mindex 55865b1..21213f1 100644[m
Binary files a/project/lecsApp/__pycache__/views.cpython-312.pyc and b/project/lecsApp/__pycache__/views.cpython-312.pyc differ
[1mdiff --git a/project/lecsApp/models.py b/project/lecsApp/models.py[m
[1mindex e014b87..13e02e5 100644[m
[1m--- a/project/lecsApp/models.py[m
[1m+++ b/project/lecsApp/models.py[m
[36m@@ -30,9 +30,11 @@[m [mclass Lec(models.Model):[m
     def __init__(self, *args: Any, **kwargs: Any) -> None:[m
         super().__init__(*args, **kwargs)[m
         pF = "templates/pages/"[m
[32m+[m[32m        print(self.image)[m
         #clear folder[m
         clearFolder(pF+"lecs")[m
         [m
[32m+[m
         content ="""{%load static%}[m
     {%block content%}[m
         <!DOCTYPE html>[m
[36m@@ -40,24 +42,28 @@[m [mclass Lec(models.Model):[m
                 <head>[m
                     <meta charset="UTF-8">[m
                     <meta name="viewport" content="width=device-width, initial-scale=1.0"><title>Document</title>    [m
[31m-                    <link rel="stylesheet" href="{% static '/css/style.css' %}">[m
[32m+[m[32m                    <link rel="stylesheet" href="{% static 'css/lecStyle.css' %}">[m
                     <link rel="stylesheet" href="{% static 'fontawesome/all.css' %}">[m
                     <link rel="stylesheet" href="{% static 'fontawesome/all.min.css' %}">[m
                 </head>[m
                 <body>[m
                     <div class="con">[m
[32m+[m[32m                        <div class="landing">[m
[32m+[m[32m                            <div class="overlay"></div>[m
[32m+[m[32m                            <div class="lecsTitle">[m
[32m+[m[32m                                <h1>السيرة</h1>[m
[32m+[m[32m                            </div>[m
[32m+[m[32m                        </div>[m
                     </div>[m
[31m-                    <static src="main.js"></static>[m
[32m+[m[32m                    <static src="lec.js"></static>[m
                 </body>[m
                 </html>[m
     {%endblock content%}"""[m
[31m-        [m
         # create htmlDocs files and folder[m
         if not path.isdir(pF+"lecs"):[m
             createFolder(pF,"lecs")[m
         for n in Lec.objects.values_list("name",flat=True):[m
             createFile(pF+"lecs/",n+".html",content)[m
[31m-            #create def views[m
     def __str__(self):[m
         return "محاضرات: "+self.name[m
     class Meta:[m
[36m@@ -76,3 +82,6 @@[m [mclass lecVideo(models.Model):[m
         verbose_name = 'فيديوات المحاضرات'[m
 [m
 [m
[32m+[m[32m@receiver(pre_save,sender=lecVideo)[m
[32m+[m[32mdef setVideoInLec(sender,instances,**kwargs):[m
[32m+[m[32m    return 0[m
[1mdiff --git a/project/lecsApp/urls.py b/project/lecsApp/urls.py[m
[1mindex c8e4dbd..d94a7d1 100644[m
[1m--- a/project/lecsApp/urls.py[m
[1m+++ b/project/lecsApp/urls.py[m
[36m@@ -1,7 +1,16 @@[m
[32m+[m[32mimport os[m
 from django.urls import path,include[m
 from . import views[m
[32m+[m[32mfrom .models import Lec[m
[32m+[m
 [m
 urlpatterns = [[m
     path('',views.index,name='index'),[m
[31m-    path('respon',views.respon,name='respon'),[m
[31m-][m
\ No newline at end of file[m
[32m+[m[32m    path('respon',views.resopn,name='respon'),[m
[32m+[m[32m][m
[32m+[m[32mpF = "templates/pages/"[m
[32m+[m[32mif os.path.isdir(pF+"lecs"):[m
[32m+[m[32m    counter = 1[m
[32m+[m[32m    for tn in Lec.objects.values_list("name",flat=True):[m
[32m+[m[32m        urlpatterns.append(path(tn.replace(" ","_"),views.lec,name=f'lec{counter}'))[m
[32m+[m[32m        counter += 1[m
[1mdiff --git a/project/lecsApp/views.py b/project/lecsApp/views.py[m
[1mindex 27527e1..be9aad4 100644[m
[1m--- a/project/lecsApp/views.py[m
[1m+++ b/project/lecsApp/views.py[m
[36m@@ -1,14 +1,22 @@[m
[32m+[m[32mfrom os import path[m
 from django.http import JsonResponse[m
[32m+[m[32mfrom .models import Lec,lecVideo[m
 from django.shortcuts import render[m
[31m-from django.core.serializers import serialize[m
[31m-from .models import Lec[m
[31m-import json[m
[32m+[m[32mfrom json import dumps[m
 [m
 def index(request):[m
[31m-    lec = Lec.objects.all()[m
[31m-    return render(request,'pages/index.html',{'lec':lec})[m
[31m-def respon(request):[m
[31m-    data = Lec.objects.values("name")[m
[31m-    return JsonResponse({"data":list(data)})[m
[32m+[m[32m    data = Lec.objects.all()[m[41m [m
[32m+[m[32m    return render(request,"pages/index.html",{"lec":data})[m
[32m+[m
[32m+[m[32mdef resopn(request):[m
[32m+[m[32m    data = list(Lec.objects.values("name"))[m
[32m+[m[41m    [m
[32m+[m[32m    return JsonResponse(data,safe=False)[m
[32m+[m
 def lec(request):[m
[31m-    return render(request,["ADAA"])[m
\ No newline at end of file[m
[32m+[m[32m    pF = "templates/pages/"[m
[32m+[m[32m    templates_names = [][m
[32m+[m[32m    if path.isdir(pF+"lecs"):[m
[32m+[m[32m        for n in Lec.objects.values_list("name",flat=True):[m
[32m+[m[32m            templates_names.append(f"pages/lecs/{n}.html")[m
[32m+[m[32m    return render(request,templates_names)[m
\ No newline at end of file[m
[1mdiff --git a/project/project/__pycache__/settings.cpython-312.pyc b/project/project/__pycache__/settings.cpython-312.pyc[m
[1mindex a60f8fc..7363383 100644[m
Binary files a/project/project/__pycache__/settings.cpython-312.pyc and b/project/project/__pycache__/settings.cpython-312.pyc differ
[1mdiff --git a/project/project/settings.py b/project/project/settings.py[m
[1mindex 82d0b1c..b30ce5a 100644[m
[1m--- a/project/project/settings.py[m
[1m+++ b/project/project/settings.py[m
[36m@@ -11,6 +11,7 @@[m [mhttps://docs.djangoproject.com/en/5.0/ref/settings/[m
 """[m
 [m
 from pathlib import Path[m
[32m+[m[32mimport os[m
 [m
 # Build paths inside the project like this: BASE_DIR / 'subdir'.[m
 BASE_DIR = Path(__file__).resolve().parent.parent[m
[36m@@ -25,7 +26,7 @@[m [mSECRET_KEY = 'django-insecure-8%@2n&vkdf+dptc8bque88c-i_mn5(7gv1f-e5kkz-vz(&1_@3[m
 # SECURITY WARNING: don't run with debug turned on in production![m
 DEBUG = True[m
 [m
[31m-ALLOWED_HOSTS = [][m
[32m+[m[32mALLOWED_HOSTS = [".vercel.app"][m
 [m
 [m
 # Application definition[m
[36m@@ -51,7 +52,7 @@[m [mMIDDLEWARE = [[m
 ][m
 [m
 ROOT_URLCONF = 'project.urls'[m
[31m-import os[m
[32m+[m
 TEMPLATES = [[m
     {[m
         'BACKEND': 'django.template.backends.django.DjangoTemplates',[m
[1mdiff --git a/project/project/static/css/style.css b/project/project/static/css/style.css[m
[1mindex 966bd49..42ae386 100644[m
[1m--- a/project/project/static/css/style.css[m
[1m+++ b/project/project/static/css/style.css[m
[36m@@ -1,15 +1,7 @@[m
[31m-:root { [m
[31m-    --mainColor: rgb(0, 123, 255);[m
[31m-    --activeColor: rgba(0, 123, 255, 0.8);[m
[31m-    --secColor: #eee;[m
[31m-    --secondaryColor: #777;[m
[31m-    --time:0.5s;[m
[31m-    --main-pad:40px; [m
[31m-}[m
[31m-@font-face {[m
[31m-    font-family: cairo;[m
[31m-    src: url("../fonts/Cairo-VariableFont_slnt\,wght.ttf");[m
[31m-}[m
[32m+[m[32m@import url("resources/colors.css");[m
[32m+[m[32m@import url("resources/fonts.css");[m
[32m+[m[32m@import url("resources/components.css");[m
[32m+[m
 html {[m
     scroll-behavior: smooth;[m
 }[m
[36m@@ -22,66 +14,6 @@[m [mbody{[m
     font-family: "cairo", serif;[m
 }[m
 [m
[31m-/* overlay component */[m
[31m-.overlay {[m
[31m-    position: absolute;[m
[31m-    left: 0;[m
[31m-    top: 0;[m
[31m-    background-color: rgba(0, 0, 0, 0.8);[m
[31m-    width: 100%;[m
[31m-    height: 100vh;[m
[31m-    z-index: 100;[m
[31m-}[m
[31m-.bodyOverlay {[m
[31m-    position: fixed;[m
[31m-    left: 0;[m
[31m-    top: 0;[m
[31m-    background-color: rgba(0, 0, 0, 0.8);[m
[31m-    width: 100%;[m
[31m-    height: 100vh;[m
[31m-    z-index: 350;[m
[31m-    display: none;[m
[31m-}[m
[31m-/*  */[m
[31m-/* container */[m
[31m-.conatiner {[m
[31m-    margin: 0 var(--main-pad);[m
[31m-[m
[31m-}[m
[31m-/*  */[m
[31m-/* title */[m
[31m-.title {[m
[31m-    position: relative;[m
[31m-    text-align: center;[m
[31m-    width: 100%;[m
[31m-    background-color: var(--mainColor);[m
[31m-    color: #fff;[m
[31m-    margin: 0 50%;[m
[31m-    margin-bottom: 40px;[m
[31m-    -o-transform: translateX(50%);[m
[31m-    -webkit-transform: translateX(50%);[m
[31m-    -moz-transform: translateX(50%);[m
[31m-    -ms-transform: translateX(50%);[m
[31m-    transform: translateX(50%);[m
[31m-    -o-border-radius: 50px;[m
[31m-    -webkit-border-radius: 50px;[m
[31m-    -moz-border-radius: 50px;[m
[31m-    -ms-border-radius: 50px;[m
[31m-    border-radius: 50px;[m
[31m-    padding: 20px 10px;[m
[31m-    -o-transition: var(--time);[m
[31m-    -webkit-transition: var(--time);[m
[31m-    -moz-transition: var(--time);[m
[31m-    -ms-transition: var(--time);[m
[31m-    transition: var(--time);[m
[31m-}[m
[31m-/*  */[m
[31m-/* a */[m
[31m-a {[m
[31m-    text-decoration: none;[m
[31m-}[m
[31m-/*  */[m
[31m-[m
 /* nav */[m
 nav {[m
     position: fixed;[m
[1mdiff --git a/project/project/static/scripts/main.js b/project/project/static/scripts/main.js[m
[1mindex bb8fa22..33fc21b 100644[m
[1m--- a/project/project/static/scripts/main.js[m
[1m+++ b/project/project/static/scripts/main.js[m
[36m@@ -10,6 +10,7 @@[m [mlet menuBar = document.querySelector("nav .menuBar");[m
 let closeMark = document.querySelector("nav .close");[m
 let olNav = document.querySelector("nav ol");[m
 let liNav = document.querySelectorAll("nav ol a");[m
[32m+[m[32mlet lecLinks = document.querySelectorAll("#lecLink");[m
 [m
 const bodyOverlay = document.querySelector(".bodyOverlay");[m
 [m
[36m@@ -55,31 +56,82 @@[m [mfunction fullNav() {[m
 [m
 // in folder lecs[m
 [m
[32m+[m[32m// HTTP requset[m
[32m+[m[32mfunction send_req(url) {[m
[32m+[m[32m    let data = [];[m
[32m+[m[32m    const requset = new XMLHttpRequest();[m
[32m+[m[32m    requset.open("GET", url, false);[m
[32m+[m[32m    requset.send(null);[m
[32m+[m[32m    if (requset.status == 200) {[m
[32m+[m[32m        data = JSON.parse(requset.responseText);[m
[32m+[m[32m    } else {[m
[32m+[m[32m        throw new Error('Request failed: ' + requset.statusText);[m
[32m+[m[32m    }[m
[32m+[m[32m    return data;[m
[32m+[m[32m}[m
 [m
[32m+[m[32mlet names = send_req("respon");[m
 [m
[32m+[m[32mnames.forEach((e, i) => { names[i] = e["name"] });[m
 [m
[32m+[m[32mlet hrefNames = [];[m
[32m+[m[32mnames.forEach(e=>{[m
[32m+[m[32m    hrefNames.push(e.replaceAll(" ","_"));[m
[32m+[m[32m});[m
 [m
 [m
[32m+[m[32mlecLinks.forEach((e,i)=>{[m
[32m+[m[32m    e.href=hrefNames[i];[m
[32m+[m[32m});[m
 [m
[32m+[m[32m// names.forEach(e => { createDoc(e); });[m
[32m+[m[32mconsole.log(1);[m
 [m
[31m-// HTTP requset[m
[31m-// function send_req(url) {[m
[31m-//     let data = [];[m
[31m-//     const requset = new XMLHttpRequest();[m
[31m-//     requset.open("GET", url, false);[m
[31m-//     requset.send(null);[m
[31m-//     if (requset.status == 200) {[m
[31m-//         data = JSON.parse(requset.responseText);[m
[31m-//     } else {[m
[31m-//         throw new Error('Request failed: ' + requset.statusText);[m
[31m-//     }[m
[31m-//     return data;[m
[31m-// }[m
[31m-[m
[31m-// let names = send_req("respon");[m
[31m-// names = names["data"];[m
[31m-[m
[31m-// names.forEach((e, i) => { names[i] = e["name"] });[m
[31m-[m
[31m-[m
[31m-// names.forEach(e => { createDoc(e); });[m
\ No newline at end of file[m
[32m+[m
[32m+[m
[32m+[m[32m//test node js[m
[32m+[m[32m// http = require('http')[m
[32m+[m[32m// const PORT = 8000;[m
[32m+[m
[32m+[m[32m// // server create[m
[32m+[m[32m// const server = http.createServer((req, res) => {[m
[32m+[m[32m//    if (req.url === "/") {[m
[32m+[m[32m//       res.write("This is home page.");[m
[32m+[m[32m//       res.end();[m
[32m+[m[32m//    } else if (req.url === "/about" && req.method === "GET") {[m
[32m+[m[32m//       res.write("This is about page.");[m
[32m+[m[32m//       res.end();[m
[32m+[m[32m//    } else {[m
[32m+[m[32m//       res.write("Not Found!");[m
[32m+[m[32m//       res.end();[m
[32m+[m[32m//    }[m
[32m+[m[32m// });[m
[32m+[m
[32m+[m[32m// // server listen port[m
[32m+[m[32m// server.listen(PORT);[m
[32m+[m
[32m+[m[32m// console.log(`Server is running on PORT: ${PORT}`);[m
[32m+[m
[32m+[m[32m// Content to write into the file[m
[32m+[m[32mvar fileContent = "This is the content of the file.";[m
[32m+[m
[32m+[m[32m// Create a Blob with the content[m
[32m+[m[32mvar blob = new Blob([fileContent], { type: 'text/plain' });[m
[32m+[m
[32m+[m[32m// Create a file name[m
[32m+[m[32mvar fileName = 'example.txt';[m
[32m+[m
[32m+[m[32m// Create a link element[m
[32m+[m[32mvar a = document.createElement('a');[m
[32m+[m[32ma.href = window.URL.createObjectURL(blob);[m
[32m+[m[32ma.download = fileName;[m
[32m+[m
[32m+[m[32m// Append the link to the body[m
[32m+[m[32mdocument.body.appendChild(a);[m
[32m+[m
[32m+[m[32m// Click the link to trigger the download[m
[32m+[m[32ma.click();[m
[32m+[m
[32m+[m[32m// Cleanup[m
[32m+[m[32mwindow.URL.revokeObjectURL(a.href);[m
[32m+[m[32mdocument.body.removeChild(a);[m
[1mdiff --git a/project/project/wsgi.py b/project/project/wsgi.py[m
[1mindex 684174a..ca2ba2f 100644[m
[1m--- a/project/project/wsgi.py[m
[1m+++ b/project/project/wsgi.py[m
[36m@@ -14,3 +14,4 @@[m [mfrom django.core.wsgi import get_wsgi_application[m
 os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project.settings')[m
 [m
 application = get_wsgi_application()[m
[32m+[m[32mapp = application[m
\ No newline at end of file[m
[1mdiff --git a/project/static/css/style.css b/project/static/css/style.css[m
[1mindex 966bd49..42ae386 100644[m
[1m--- a/project/static/css/style.css[m
[1m+++ b/project/static/css/style.css[m
[36m@@ -1,15 +1,7 @@[m
[31m-:root { [m
[31m-    --mainColor: rgb(0, 123, 255);[m
[31m-    --activeColor: rgba(0, 123, 255, 0.8);[m
[31m-    --secColor: #eee;[m
[31m-    --secondaryColor: #777;[m
[31m-    --time:0.5s;[m
[31m-    --main-pad:40px; [m
[31m-}[m
[31m-@font-face {[m
[31m-    font-family: cairo;[m
[31m-    src: url("../fonts/Cairo-VariableFont_slnt\,wght.ttf");[m
[31m-}[m
[32m+[m[32m@import url("resources/colors.css");[m
[32m+[m[32m@import url("resources/fonts.css");[m
[32m+[m[32m@import url("resources/components.css");[m
[32m+[m
 html {[m
     scroll-behavior: smooth;[m
 }[m
[36m@@ -22,66 +14,6 @@[m [mbody{[m
     font-family: "cairo", serif;[m
 }[m
 [m
[31m-/* overlay component */[m
[31m-.overlay {[m
[31m-    position: absolute;[m
[31m-    left: 0;[m
[31m-    top: 0;[m
[31m-    background-color: rgba(0, 0, 0, 0.8);[m
[31m-    width: 100%;[m
[31m-    height: 100vh;[m
[31m-    z-index: 100;[m
[31m-}[m
[31m-.bodyOverlay {[m
[31m-    position: fixed;[m
[31m-    left: 0;[m
[31m-    top: 0;