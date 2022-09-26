import 'package:flutter/material.dart';
import 'package:gest_loc/controller/auth_controller.dart';
import 'package:gest_loc/controller/main_controller.dart';
import 'package:gest_loc/page/calendar_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const MainController(),
    );
  }
}
