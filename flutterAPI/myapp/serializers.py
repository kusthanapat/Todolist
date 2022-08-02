#serializers.py เป็นการให้เราเลือกว่าเราจะแสดงอะไรบ้าง

#from dataclasses import field
from rest_framework import serializers
from .models import Todolist

class TodolistSerializer(serializers.ModelSerializer):
    class Meta:
        model = Todolist
        fields = ('id','title','detail') #หรือใช้ fields = ('__all__') เป็นการเอาทั้งหมดในลิสต์เลย


