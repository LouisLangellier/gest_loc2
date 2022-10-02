import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gest_loc/model/member.dart';
import 'package:gest_loc/page/add_modify_location_page.dart';
import 'package:gest_loc/util/constant.dart';
import 'package:gest_loc/util/firebase_handler.dart';

import '../controller/loading_controller.dart';

class LocationListPage extends StatefulWidget {
  Member member;
  LocationListPage({Key? key, required this.member}) : super(key: key);

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseHandler()
          .fireMember
          .doc(widget.member.uid)
          .collection(locationRef)
          .snapshots(),
      builder: (context, snapshots) {
        if (snapshots.data == null) {
          return const LoadingController();
        }
        if (snapshots.data!.docs.isEmpty) {
          return Scaffold(
            body: const Center(
              child: Text(
                  "On dirait que personne ne veut louer vos appartements..."),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddModifyLocationPage(
                        member: widget.member,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
