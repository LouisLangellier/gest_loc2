import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gest_loc/model/member.dart';
import 'package:gest_loc/page/appart_page.dart';
import 'package:gest_loc/page/calendar_page.dart';
import 'package:gest_loc/page/settings_page.dart';
import 'package:gest_loc/util/firebase_handler.dart';
import 'package:gest_loc/controller/loading_controller.dart';

class MainController extends StatefulWidget {
  String memberUid;
  MainController({Key? key, required this.memberUid}) : super(key: key);

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  late StreamSubscription streamSubscription;
  int _currentIndex = 0;
  Member? member;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    streamSubscription = FirebaseHandler()
        .fireMember
        .doc(widget.memberUid)
        .snapshots()
        .listen((event) {
      setState(() {
        member = Member(event);
      });
    });
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if ((member == null)) {
      return const LoadingController();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("GestLoc"),
          ),
        ),
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: [
              Center(child: CalendarPage(member: member!)),
              Center(child: AppartPage(member: member!)),
              Center(child: SettingsPage(member: member!)),
              Center(child: SettingsPage(member: member!)),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.calendar_month),
              title: const Center(child: Text("Calendrier")),
              activeColor: Colors.pink,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.house),
              title: const Center(child: Text("Apparts")),
              activeColor: Colors.pink,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.message),
              title: const Center(child: Text("Messages")),
              activeColor: Colors.pink,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.person),
              title: const Center(child: Text("Paramètres")),
              activeColor: Colors.pink,
            ),
          ],
        ),
      );
    }
  }
}
