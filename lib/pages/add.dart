import 'package:flutter/material.dart';

//http mothod
import 'dart:convert';
import 'package:http/http.dart' as http; // as เป็นการตั้งชื่อเล่น เวาลาเราใช้เรียกตัวนี้ก็ใช่ชื่อ http ทีี่ตั้งไว้หลัง as ได้เลย
import 'dart:async';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController(); 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add list'),),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            //ช่องกรอกข้อมูลของ todolist
            TextField(
                    controller: todo_title,
                    decoration: InputDecoration(
                        labelText: 'todolist', border: OutlineInputBorder())),
            SizedBox(height: 30,),
            TextField(
                    minLines: 3,
                    maxLines: 6,
                    controller: todo_detail,
                    decoration: InputDecoration(
                        labelText: 'detail', border: OutlineInputBorder())),
            SizedBox(height: 30,),
            //ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                      onPressed: () {
                        print('----------------------');
                        print('title : ${todo_title.text}');
                        print('detail : ${todo_detail.text}');
                        postTodo();
                        setState(() {
                          todo_title.clear();
                          todo_detail.clear();
                        });  //setStateเป็นฟังก์ชั่นสำหรับการรีเฟรชหน้า

                      },

                      child: Text('add'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xff5DA8D1)),
                        padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(40, 20, 40, 20)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontFamily: 'krasib',fontSize: 30))),),
            ),

            
          ],
        ),
      ),
      
    );
  }

  Future postTodo() async{
    //var url = Uri.https('6430-2405-9800-b870-dc39-7c5f-bc79-5a90-cad8.ngrok.io', '/api/post-todolist');
    var url = Uri.http('192.168.1.145:8000', '/api/post-todolist'); //รันผ่านipเครื่อง
    Map<String,String> header = {'content-type':'application/json'};  //content-type':'application/json ต้องพิมให้ถูกตามนี้
    String jsondata = '{"title": "${todo_title.text}" , "detail": "${todo_detail.text}"}';
    var response = await http.post(url,headers: header,body: jsondata);  //await จะใช้คู่กับ async
    print('---------rusult---------');
    print(response.body);
  }

}