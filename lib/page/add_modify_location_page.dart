import 'package:flutter/material.dart';

import '../model/member.dart';

class AddModifyLocationPage extends StatefulWidget {
  Member member;
  AddModifyLocationPage({super.key, required this.member});

  @override
  State<AddModifyLocationPage> createState() => _AddModifyLocationPageState();
}

class _AddModifyLocationPageState extends State<AddModifyLocationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("GestLoc"),
        ),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
