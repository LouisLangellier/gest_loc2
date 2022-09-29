import 'package:flutter/material.dart';
import 'package:gest_loc/model/member.dart';
import 'package:gest_loc/page/add_appart_page.dart';

class AppartPage extends StatefulWidget {
  Member member;
  AppartPage({Key? key, required this.member}) : super(key: key);

  @override
  State<AppartPage> createState() => _AppartPageState();
}

class _AppartPageState extends State<AppartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Appart"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAppartPage(member: widget.member,)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
