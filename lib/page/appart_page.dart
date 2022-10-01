import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gest_loc/controller/loading_controller.dart';
import 'package:gest_loc/model/apartment.dart';
import 'package:gest_loc/model/member.dart';
import 'package:gest_loc/page/add_appart_page.dart';
import 'package:gest_loc/util/constant.dart';
import 'package:gest_loc/util/firebase_handler.dart';

class AppartPage extends StatefulWidget {
  Member member;
  AppartPage({Key? key, required this.member}) : super(key: key);

  @override
  State<AppartPage> createState() => _AppartPageState();
}

class _AppartPageState extends State<AppartPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseHandler()
            .fireMember
            .doc(widget.member.uid)
            .collection(apartmentRef)
            .snapshots(),
        builder: (BuildContext context, snapshots) {
          if (snapshots.data == null) {
            return const LoadingController();
          }
          if (snapshots.data!.docs.isEmpty) {
            return Scaffold(
              body: const Center(
                child: Text("Ajoutez des appartements pour commencer !"),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAppartPage(
                        member: widget.member,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
          } else {
            return Scaffold(
              body: ListView.builder(
                itemCount: snapshots.data!.docs.length,
                itemBuilder: (context, index) {
                  final apartmentList = snapshots.data!.docs;
                  final apartment = Apartment(apartmentList[index]);
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 10, right: 10, bottom: 7.5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 8,
                      child: ListTile(
                        //TODO : ajouter une image de l'appartement avec leading
                        title: Text(apartment.name),
                        subtitle: Text(apartment.description),
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAppartPage(
                        member: widget.member,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
          }
        });
  }
}
