import 'package:flutter/material.dart';

//http mothod
import 'dart:convert';
import 'package:http/http.dart'
    as http; // as เป็นการตั้งชื่อเล่น เวาลาเราใช้เรียกตัวนี้ก็ใช่ชื่อ http ทีี่ตั้งไว้หลัง as ได้เลย
import 'dart:async';

import 'package:todolist/pages/todolist.dart';

class UpdatePage extends StatefulWidget {
  final v1, v2, v3;
  const UpdatePage(
      this.v1, this.v2, this.v3); //const = enit function in pythhon

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  var _v1, _v2, _v3;
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _v1 = widget.v1; //this is ID
    _v2 = widget.v2; //This is title
    _v3 = widget.v3; //This is detail

    todo_title.text = _v2;
    todo_detail.text = _v3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: [
          IconButton(
              onPressed: () {
                print('delete id : $_v1');
                deleteTodo();
                Navigator.pop(context,
                    'delete'); //.pop คือ ถ้าลบแล้วจะกลับไปหน้าหลัก เหมือนการกด back
              },
              icon: Icon(
                Icons.delete,
                color: Colors.red[900],
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            //ช่องกรอกข้อมูลของ todolist
            TextField(
                controller: todo_title,
                decoration: InputDecoration(
                    labelText: 'todolist', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            TextField(
                minLines: 3,
                maxLines: 6,
                controller: todo_detail,
                decoration: InputDecoration(
                    labelText: 'detail', border: OutlineInputBorder())),
            SizedBox(
              height: 30,
            ),
            //ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(50),
              child: ElevatedButton(
                onPressed: () {
                  print('----------------------');
                  print('title : ${todo_title.text}');
                  print('detail : ${todo_detail.text}');
                  updateTodo();
                  final snackBar = SnackBar(
                    content: const Text('list has been updated'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  //setStateเป็นฟังก์ชั่นสำหรับการรีเฟรชหน้า
                },
                child: Text('Edit'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xff5DA8D1)),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.fromLTRB(40, 20, 40, 20)),
                    textStyle: MaterialStateProperty.all(
                        TextStyle(fontFamily: 'krasib', fontSize: 30))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateTodo() async {
    //var url = Uri.https('6430-2405-9800-b870-dc39-7c5f-bc79-5a90-cad8.ngrok.io', '/api/post-todolist');
    //ngrok ต้องเปลี่ยน url ใหม่ทุกครั้ง มันน่าจะเปลี่ยนทุก2ชม ไปรัน ngrokแล้วเอา url มาใส่ใหม่ทุกครั้ง
    var url = Uri.http(
        '192.168.1.145:8000', '/api/update-todolist/$_v1'); //รันผ่านipเครื่อง
    Map<String, String> header = {
      'content-type': 'application/json'
    }; //content-type':'application/json ต้องพิมให้ถูกตามนี้
    String jsondata =
        '{"title": "${todo_title.text}" , "detail": "${todo_detail.text}"}';
    var response = await http.put(url,
        headers: header, body: jsondata); //await จะใช้คู่กับ async
    print('---------rusult---------');
    print(response.body);
  }

  Future deleteTodo() async {
    var url = Uri.http('192.168.1.145:8000', '/api/delete-todolist/$_v1');
    Map<String, String> header = {'content-type': 'application/json'};
    var response =
        await http.delete(url, headers: header); //await จะใช้คู่กับ async
    print('---------rusult---------');
    print(response.body);
  }
}
