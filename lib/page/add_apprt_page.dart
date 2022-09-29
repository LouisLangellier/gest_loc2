import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddAppartPage extends StatefulWidget {
  const AddAppartPage({super.key});

  @override
  State<AddAppartPage> createState() => _AddAppartPageState();
}

class _AddAppartPageState extends State<AddAppartPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Nouvel appart"),
      ),
    );
  }
}
