import 'package:flutter/material.dart';

import '../model/member.dart';

class AddModifyLocationPage extends StatefulWidget {
  Member member;
  AddModifyLocationPage({super.key, required this.member});

  @override
  State<AddModifyLocationPage> createState() => _AddModifyLocationPageState();
}

class _AddModifyLocationPageState extends State<AddModifyLocationPage> {
  final _formLocationKey = GlobalKey<FormState>();
  late TextEditingController _name;
  late TextEditingController _firstName;
  late TextEditingController _mail;
  late TextEditingController _phone;
  DateTime? _begin;
  DateTime? _end;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _firstName = TextEditingController();
    _mail = TextEditingController();
    _phone = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _firstName.dispose();
    _mail.dispose();
    _phone.dispose();
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
      body: SingleChildScrollView(
        child: Form(
          key: _formLocationKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 7.5),
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
                      hintText: "Nom du locataire",
                      prefixIcon: const Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 7.5, left: 15, right: 15, bottom: 7.5),
                child: TextFormField(
                  controller: _firstName,
                  validator: (String? value) =>
                      value!.isEmpty ? "Le champ nom doit être rempli" : null,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: "Prénom du locataire",
                      prefixIcon: const Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 7.5, left: 15, right: 15, bottom: 7.5),
                child: TextFormField(
                  controller: _mail,
                  validator: (String? value) =>
                      value!.isEmpty ? "Le champ nom doit être rempli" : null,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: "Email du locataire",
                      prefixIcon: const Icon(Icons.mail_outline)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 7.5, left: 15, right: 15, bottom: 7.5),
                child: TextFormField(
                  controller: _phone,
                  validator: (String? value) =>
                      value!.isEmpty ? "Le champ nom doit être rempli" : null,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      hintText: "Téléphone du locataire",
                      prefixIcon: const Icon(Icons.phone)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 7.5, left: 30, right: 30, bottom: 7.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Date de début :"),
                    (_begin == null)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: const Text("Ajouter une date"))
                        : Text(
                            "${_begin!.day} ${_begin!.month} ${_begin!.year}")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 7.5, left: 30, right: 30, bottom: 7.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Date de fin :"),
                    (_end == null)
                        ? ElevatedButton(
                            onPressed: () {},
                            child: const Text("Ajouter une date"))
                        : Text("${_end!.day} ${_end!.month} ${_end!.year}")
                  ],
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
                      if (_formLocationKey.currentState!.validate()) {}
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
      ),
    );
  }
}
