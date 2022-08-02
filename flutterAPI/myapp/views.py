from django.shortcuts import render
from django.http import JsonResponse
#from itsdangerous import Serializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TodolistSerializer
from .models import Todolist


# Create your views here.



#get data
@api_view(['GET'])
def all_todolist(request):
    alltodolist = Todolist.objects.all() #ดึงข้อมูลจาก model todolist
    serializer = TodolistSerializer(alltodolist,many = True)
    return Response(serializer.data, status = status.HTTP_200_OK)


#POST Data (save data to database)
@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodolistSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)


@api_view(['PUT'])
def update_todolist(request,TID):
    #localhost:8000/api/update-todolist/TID TIDจะเป็นตัวIDที่ใช้เรียก เช่น ข้อมูลที่ID=20 จะใช้ localhost:8000/api/update-todolist/20 ประมาณนี้
    todo = Todolist.objects.get(id=TID)

    #check method
    if request.method == 'PUT':
        data = {}
        serealizer = TodolistSerializer(todo,data=request.data) #ถ้าไม่ใส่ todo ในวงเล็บกลายเป็นการสร้าง data ใหม่แทน
        if serealizer.is_valid():
            serealizer.save()
            data['status'] = 'updated'
            return Response(data=data, status=status.HTTP_201_CREATED)
        return Response(serealizer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_todolist(request,TID):
    todo =Todolist.objects.get(id=TID)
    
    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else :
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        return Response(data=data , status=statuscode)



data = [

    {
        "title":"Travel Trip",
        "subtitle":"'ทริปเที่ยวทั่วโลกมากมาย'",
        "URL_image":"https://raw.githubusercontent.com/kusthanapat/BasicAPI/main/travel.jpg",
        "detail":"เที่ยวรอบโลกไปกับเรา พร้อมโปรสุดพิเศษมากมาย คุณสามารถเลือกสถานที่ได้ที่หน้าโฮมเพจ"
    },
    {
        "title":"Japan",
        "subtitle":"'โปรโมชั่นพิเศษาำหรับเที่ยวญี่ปุ่น'",
        "URL_image":"https://raw.githubusercontent.com/kusthanapat/BasicAPI/main/japan.jpg",
        "detail":"เที่ยวญี่ปุ่น10วันพร้อมกิจกรรมและสถานที่สุดปัง ประเทศญี่ปุ่นมีเกาะรวม 6,852 เกาะ ทอดตามชายฝั่งแปซิฟิกของเอเชียตะวันออก ประเทศญี่ปุ่นรวมทุกเกาะตั้งอยู่ระหว่างละติจูด 24 องศา และ 46 องศาเหนือ \n\nและลองจิจูด 122 องศา และ 146 องศาตะวันออก หมู่เกาะหลักไล่จากเหนือลงใต้ ได้แก่ ฮกไกโด ฮนชู ชิโกกุ และคีวชู หมู่เกาะรีวกีวรวมทั้งเกาะโอกินาวะเรียงกันอยู่ทางใต้ของคีวชู รวมกันมักเรียกว่า กลุ่มเกาะญี่ปุ่นพื้นที่ประมาณร้อยละ 73 ของประเทศญี่ปุ่นเป็นป่าไม้ ภูเขาและไม่เหมาะกับการใช้ทางการเกษตร อุตสาหกรรม หรือการอยู่อาศัยด้วยเหตุนี้ เขตอยู่อาศัยได้ซึ่งตั้งอยู่ในบริเวณชายฝั่งเป็นหลัก จึงมีความหนาแน่นของประชากรสูงมาก ประเทศญี่ปุ่นเป็นประเทศที่มีความหนาแน่นของประชากรสูงสุดของโลกประเทศหนึ่ง"
    },
    {
        "title":"Switzerland",
        "subtitle":"'ทริปสุดพิเศษที่สวิต'",
        "URL_image":"https://raw.githubusercontent.com/kusthanapat/BasicAPI/main/swit.jpg",
        "detail":"เที่ยวธรรมชาติสุดทึ่ง สวยจนตายตาหลับ ตั้งทางภูมิศาสตร์ของสวิตเซอร์แลนด์อยู่ระหว่าง ที่ราบสูงสวิส เทือกเขาแอลป์ และ เทือกเขาจูรา ซึ่งครอบคลุมพื้นที่ทั้งหมด 41,285 ตารางกิโลเมตร (15,940 ตารางไมล์) และมีพื้นที่แผ่นดินรวม 39,997 ตารางกิโลเมตร (15,443 ตารางไมล์) แม้ว่าเทือกเขาแอลป์จะครอบคลุมพื้นที่ส่วนใหญ่ของประเทศ แต่ประชากรเกือบทั้งหมดอาศัยอยู่ในพื้นที่ราบสูงซึ่งเป็นที่ตั้งของเมืองใหญ่และเป็นศูนย์กลางทางเศรษฐกิจ\n\nได้แก่ ซือริช เจนีวา และบาเซิล เมืองเหล่านี้เป็นที่ตั้งสำนักงานขององค์การระหว่างประเทศหลายแห่ง เช่น องค์การการค้าโลก องค์การอนามัยโลกองค์ การแรงงานระหว่างประเทศ, สหพันธ์ฟุตบอลระหว่างประเทศสหประชาชาติและธนาคารเพื่อการชำระบัญชีระหว่างประเทศ นอกจากนี้ท่าอากาศยานหลักของประเทศก็ตั้งอยู่ในเมืองเหล่านี้เช่นกัน สวิตเซอร์แลนด์เป็นประเทศที่วางตัวเป็นกลางทางการเมืองมาหลายศตวรรษ"
    },
    {
        "title":"France",
        "subtitle":"'ทริปสุดโรเมนติกที่ปารีส'",
        "URL_image":"https://raw.githubusercontent.com/kusthanapat/BasicAPI/main/france.jpg",
        "detail":"พาคุณไปสวีทที่ปารีส และเที่ยวหาดที่นอร์มังดี ประเทศฝรั่งเศสภาคพื้นทวีปยุโรปตั้งอยู่ระหว่าง 41° and 50° เหนือ บนขอบทวีปยุโรปตะวันตกและตั้งอยู่ในภูมิอากาศเขตอบอุ่นเหนือ ทางภาคเหนือและตะวันตกเฉียงเหนือมีสภาพภูมิอากาศเขตอบอุ่น แต่กระนั้นภูมิประเทศและทะเลก็มีอิทธิพลต่อภูมิอากาศเหมือนกัน ละติจูด ลองจิจูดและความสูงเหนือระดับน้ำทะเลทำให้ประเทศฝรั่งเศสมีภูมิอากาศแบบคละอีกด้วย ทางภาคตะวันออกเฉียงใต้มีสภาพภูมิอากาศแบบเมดิเตอร์เรเนียน ภาคตะวันตกส่วนมากจะมีปริมาณน้ำฝนสูง\n\nฤดูหนาวไม่มากและฤดูร้อนเย็นสบาย ภายในประเทศภูมิอากาศจะเปลี่ยนไปทางภาคพื้นทวีปยุโรป อากาศร้อน มีมรสุมในฤดูร้อน ฤดูหนาวหนาวกว่าเดิมและมีฝนตกน้อย ส่วนภูมิอากาศเทือกเขาแอลป์และแถบบริเวณเทือกเขาอื่น ๆ ส่วนมากมักจะมีภูมิอากาศแถบเทือกเขา ด้วยอุณหภูมิต่ำกว่าจุดเยือกแข็งกว่า 150 วันต่อปีและปกคลุมด้วยหิมะกว่า 6 เดือน"
    },
    {
        "title":"Singapore",
        "subtitle":"'เที่ยวสุดหรูที่สิงคโปร์'",
        "URL_image":"https://raw.githubusercontent.com/kusthanapat/BasicAPI/main/singapore.jpg",
        "detail":"สิงคโปร์ ถือเป็นอีกจุดหมายที่คนไทยนิยมไปท่องเที่ยวมากที่สุด เพราะนอกจากจะเดินทางไม่ไกลแล้ว ที่นี่ยังเป็นศูนย์รวมวัฒนธรรมที่หลากหลาย แหล่งท่องเที่ยว แหล่งช้อปปิ้ง และของอร่อยมากมายที่ใครๆ ก็อยากลองไปสัมผัสด้วยตัวเองสักครั้ง"
    }


]


def Home(request) :
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii':False})
