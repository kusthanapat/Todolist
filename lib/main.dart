import 'package:flutter/material.dart';
import 'package:todolist/pages/todolist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //เอาคำว่า debud ตรง แถบ title ออก
      title: 'Todolist App',
      home: Todolist(),
    );
  }
}
