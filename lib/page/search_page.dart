import 'package:flutter/material.dart';
import 'package:gest_loc/model/member.dart';

class SearchPage extends StatefulWidget {
  Member member;
  SearchPage({Key? key, required this.member}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Onglet de recherche"),
      ),
    );
  }
}
