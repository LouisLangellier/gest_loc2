import 'package:flutter/material.dart';
import 'package:gest_loc/model/apartment.dart';
import 'package:gest_loc/model/member.dart';
import 'package:gest_loc/page/add_modify_appart_page.dart';
import 'package:gest_loc/util/constant.dart';
import 'package:gest_loc/util/firebase_handler.dart';

class AppartPage extends StatefulWidget {
  Member member;
  Apartment apartment;
  AppartPage({super.key, required this.apartment, required this.member});

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
              padding: const EdgeInsets.only(top: 25, bottom: 20),
              child: Image(
                height: MediaQuery.of(context).size.height * 0.3,
                image: NetworkImage(widget.apartment.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text("Nom : ${widget.apartment.name}"),
                  Text("Adresse : ${widget.apartment.address}"),
                  Text("Description : ${widget.apartment.description}")
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddModifyAppartPage(
                    member: widget.member,
                    apartment: widget.apartment,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.black,
            ),
            label: const Text(
              "Modifier",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Confirmation de suppression"),
                  content:
                      Text("Voulez-vous supprimer ${widget.apartment.name} ?"),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Annuler")),
                    ElevatedButton(
                        onPressed: () {
                          FirebaseHandler().deleteApartmentFromFirebase(
                              widget.apartment.memberUid,
                              widget.apartment.uid,
                              widget.apartment.date);
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Confirmer")),
                  ],
                ),
              );
            },
            label: const Text("Supprimer"),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
