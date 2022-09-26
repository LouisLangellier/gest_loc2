import 'package:flutter/material.dart';

class AppartPage extends StatefulWidget {
  const AppartPage({Key? key}) : super(key: key);

  @override
  State<AppartPage> createState() => _AppartPageState();
}

class _AppartPageState extends State<AppartPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Appart"),
      ),
    );
  }
}
