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
          const Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              //TODO : onTap: (){}, Action pour ouvrir profil
              child: Card(
                elevation: 5,
                child: ListTile(
                  title: Text(
                    "Profil",
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                FirebaseHandler().logOut();
                //TODO ajouter une demande de confirmation
              },
              child: const Card(
                elevation: 5,
                child: ListTile(
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
