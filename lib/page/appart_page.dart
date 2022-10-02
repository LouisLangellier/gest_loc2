import 'package:flutter/material.dart';
import 'package:gest_loc/model/apartment.dart';
import 'package:gest_loc/util/constant.dart';
import 'package:gest_loc/util/firebase_handler.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: Center(
                child: CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.pink,
                  child: CircleAvatar(
                    radius: 117,
                    backgroundImage: NetworkImage(widget.apartment.imageUrl),
                  ),
                ),
              ),
            ),
            const Divider(),
            Column(
              children: [
                Text("Nom : ${widget.apartment.name}"),
                Text("Adresse : ${widget.apartment.address}"),
                Text("Description : ${widget.apartment.description}")
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            label: const Text(
              "Modifier",
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              FirebaseHandler().deleteApartmentFromFirebase(
                  widget.apartment.memberUid,
                  widget.apartment.uid,
                  widget.apartment.date);
              //TODO : demande de confirmation de suppression
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            label: const Text(
              "Supprimer",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
