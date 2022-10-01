import 'package:flutter/material.dart';
import 'package:gest_loc/model/apartment.dart';

class AppartPage extends StatefulWidget {
  Apartment apartment;
  AppartPage({super.key, required this.apartment});

  @override
  State<AppartPage> createState() => _AppartPageState();
}

class _AppartPageState extends State<AppartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.apartment.name)),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
