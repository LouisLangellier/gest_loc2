import 'package:flutter/material.dart';
import 'package:gest_loc/model/member.dart';

class CalendarPage extends StatefulWidget {
  Member member;
  CalendarPage({Key? key, required this.member}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(),
    );
  }
}
