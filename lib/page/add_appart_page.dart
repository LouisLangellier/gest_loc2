import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gest_loc/util/constant.dart';
import 'package:gest_loc/util/firebase_handler.dart';

import '../model/member.dart';

class AddAppartPage extends StatefulWidget {
  Member member;
  AddAppartPage({super.key, required this.member});

  @override
  State<AddAppartPage> createState() => _AddAppartPageState();
}

class _AddAppartPageState extends State<AddAppartPage> {
  final _formAddAppartKey = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _address;
  late TextEditingController _description;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _address = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("GestLoc"),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: _formAddAppartKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 15, right: 15, bottom: 7.5),
              child: TextFormField(
                controller: _name,
                validator: (String? value) =>
                    value!.isEmpty ? "Le champ nom doit être rempli" : null,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "Nom de l'appartement",
                    prefixIcon: const Icon(Icons.password)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 7.5, left: 15, right: 15, bottom: 7.5),
              child: TextFormField(
                controller: _address,
                validator: (String? value) =>
                    value!.isEmpty ? "Le champ nom doit être rempli" : null,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "Adresse de l'appartement",
                    prefixIcon: const Icon(Icons.password)),
              ),
            ),
            //TODO changer le textFormField en TextArea
            Padding(
              padding: const EdgeInsets.only(
                  top: 7.5, left: 15, right: 15, bottom: 7.5),
              child: TextFormField(
                controller: _description,
                validator: (String? value) =>
                    value!.isEmpty ? "Le champ nom doit être rempli" : null,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    hintText: "Description",
                    prefixIcon: const Icon(Icons.password)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 7.5, left: 15, right: 15, bottom: 7.5),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const StadiumBorder()),
                  child: const Text(
                    "Annuler",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 7.5, left: 15, right: 15, bottom: 7.5),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formAddAppartKey.currentState!.validate()) {
                      FirebaseHandler().addApartmentToFirebase(_name.text,
                          _address.text, _description.text, widget.member.uid);
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder()),
                  child: const Text(
                    "Ajouter",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
