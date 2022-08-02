from django.urls import path
from .views import *        # *คือดึงมาทุกฟังก์ชั่น ใน.view

urlpatterns = [
    path('', Home),
    path('api/all-todolist/',all_todolist),
    path('api/post-todolist',post_todolist),
    path('api/update-todolist/<int:TID>' ,update_todolist),
    path('api/delete-todolist/<int:TID>',delete_todolist),
]