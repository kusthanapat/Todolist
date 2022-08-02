#from turtle import title
from django.db import models   # ไฟล์ model.py ใข้สำหรับจัดเก็บข้อมูล(ไฟล์ฐานข้อมูล) เป็นฐานข้อมูลในระบบdjango

# Create your models here.

class Todolist(models.Model):
    title = models.CharField(max_length=100)
    detail = models.TextField(null=True,blank=True)  #ถ้าจะเปลี่ยนแปลงคำสั่งที่อยู่ใน model ต้องรัน makekigrations และ migrate ใน cmd ใหม่ด้วยทุกครั้ง

    def __str__(self):
        return self.title
    
