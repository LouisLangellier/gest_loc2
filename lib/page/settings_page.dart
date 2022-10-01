import 'package:flutter/material.dart';
import 'package:gest_loc/model/member.dart';
import 'package:gest_loc/util/firebase_handler.dart';

class SettingsPage extends StatefulWidget {
  Member member;
  SettingsPage({Key? key, required this.member}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20, left: 10, right: 10, bottom: 7.5),
            child: InkWell(
              //TODO : onTap: (){}, Action pour ouvrir profil
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: const ListTile(
                  title: Text(
                    "Profil",
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.only(
                top: 7.5, left: 10, right: 10, bottom: 7.5),
            child: InkWell(
              onTap: () {
                FirebaseHandler().logOut();
                //TODO ajouter une demande de confirmation
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                child: const ListTile(
                  title: Text(
                    "Se déconnecter",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
