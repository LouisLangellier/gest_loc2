import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Padding(
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
          Divider(),
          Padding(
            padding: EdgeInsets.all(10),
            child: InkWell(
              //TODO : onTap: (){}, Action pour se déconnecter
              child: Card(
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
