import 'package:flutter/material.dart';
import '../model/member.dart';

class ContactListPage extends StatefulWidget {
  Member member;
  ContactListPage({super.key, required this.member});

  @override
  State<ContactListPage> createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            Text("Vous n'avez encore échangé avec personne... Corrigez cela !"),
      ),
    );
  }
}
