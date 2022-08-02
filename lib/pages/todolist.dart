import 'package:flutter/material.dart';
import 'package:todolist/pages/add.dart';

import 'dart:convert';
import 'package:http/http.dart'
    as http; // as เป็นการตั้งชื่อเล่น เวาลาเราใช้เรียกตัวนี้ก็ใช่ชื่อ http ทีี่ตั้งไว้หลัง as ได้เลย
import 'dart:async';

import 'package:todolist/pages/update_todolist.dart';

class Todolist extends StatefulWidget {
  //const Todolist({ Key? key }) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  List todolistItem = [];

  //initState เป็นฟังก์ชั่นที่จะทำการรันทุกครั้งที่หน้านี้เปิดขึ้นมา
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettodoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddPage()))
              .then((value) {
            setState(() {
              gettodoList();
              final snackBar = SnackBar(
            content: const Text('list has been added'),
            
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
            });
          });
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  gettodoList();
                });
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ))
        ],
        title: Text('All Todolist'),
      ),
      body: todolistCreate(),
    );
  }

  Widget todolistCreate() {
    return ListView.builder(
        itemCount: todolistItem.length,
        itemBuilder: (context, index) {
          return Card(
              child: ListTile(
            title: Text("${todolistItem[index]['title']}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdatePage(
                          todolistItem[index]['id'],
                          todolistItem[index]['title'],
                          todolistItem[index]['detail']))).then((value) {
                setState(() {
                  gettodoList();
                  print(value);
                  if (value == 'delete') {
                    final snackBar = SnackBar(
                      content: const Text('list has been deleted'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                });
              }); //.then ตรงนี้คือ เมื่อbackกลับมาแล้ว จะให้ทำอะไร when you back,what u want it to do
              //.then เป็นการเรียกใช้ฟังก์ชั่นเลย(ถ้าเอาตัว => มาด้วย แต่อันนี้ลบออกไปเพื่อให้ใส่ setState ได้)
            },
          )); //Card เป็นความสามารถพิเศษของ flutter เป็นการสร้าง blox ขึ้นมา
        });
  }

  Future<void> gettodoList() async {
    List alltodo = [];
    var url = Uri.http('192.168.1.145:8000', '/api/all-todolist');
    var response = await http.get(url);
    //var result = jsonDecode(response.body);
    var result = utf8.decode(response.bodyBytes);
    print(result);
    setState(() {
      todolistItem = jsonDecode(result);
    });
  }
}
