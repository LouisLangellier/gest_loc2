import 'package:flutter/material.dart';
import 'package:gest_loc/util/firebase_handler.dart';

import '../model/member.dart';
import '../util/utils.dart';

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
  late DateTime _begin;
  late DateTime _end;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _firstName = TextEditingController();
    _mail = TextEditingController();
    _phone = TextEditingController();
    _begin = DateTime.now();
    _end = DateTime.now().add(const Duration(days: 1));
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
                child: buildDateTimePickers(),
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
                      if (_formLocationKey.currentState!.validate()) {
                        addLocationToFirebase();
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
      ),
    );
  }

  Widget buildDateTimePickers() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 5),
          child: buildBegin(),
        ),
        buildEnd(),
      ],
    );
  }

  Widget buildBegin() {
    return buildHeader(
      header: "De",
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
                text: Utils.toDate(_begin),
                onClick: () {
                  pickFromDateTime(pickDate: true);
                }),
          ),
          Expanded(
            child: buildDropdownField(
                text: Utils.toTime(_begin),
                onClick: () {
                  pickFromDateTime(pickDate: false);
                }),
          ),
        ],
      ),
    );
  }

  Widget buildEnd() {
    return buildHeader(
      header: "Jusqu'à",
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: buildDropdownField(
                text: Utils.toDate(_end),
                onClick: () {
                  pickToDateTime(pickDate: true);
                }),
          ),
          Expanded(
            child: buildDropdownField(
                text: Utils.toTime(_end),
                onClick: () {
                  pickToDateTime(pickDate: false);
                }),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClick,
  }) {
    return ListTile(
      title: Text(text),
      trailing: const Icon(Icons.arrow_drop_down),
      onTap: onClick,
    );
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        child
      ],
    );
  }

  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(_begin, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(_end)) {
      _end =
          DateTime(date.year, date.month, date.day + 1, _end.hour, _end.minute);
    }

    setState(() {
      _begin = date;
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(_end,
        pickDate: pickDate, firstDate: pickDate ? _begin : null);
    if (date == null) return;

    setState(() {
      _end = date;
    });
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime.now(),
        lastDate: DateTime(2101),
      );
      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }

  addLocationToFirebase() {
    int begin = Utils.dateTimeToInt(_begin);
    int end = Utils.dateTimeToInt(_end);
    //FirebaseHandler().addLocationToFirebase(widget.member.uid, apartmentUid, name, firstName, mail, phone, dateBegin, dateEnd)
  }
}
