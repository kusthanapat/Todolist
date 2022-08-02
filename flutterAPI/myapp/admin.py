from django.contrib import admin #ฝั่งเบื้องหลัง 

# Register your models here.

from .models import Todolist

admin.site.register(Todolist) # เป็นการทำให้ข้อมูล todolist จากหน้า model มาแสดงให้ฝั่งผู้ดูแล(admin)