import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gest_loc/page/appart_page.dart';
import 'package:gest_loc/page/calendar_page.dart';
import 'package:gest_loc/page/settings_page.dart';

class MainController extends StatefulWidget {
  const MainController({Key? key}) : super(key: key);

  @override
  State<MainController> createState() => _MainControllerState();
}

class _MainControllerState extends State<MainController> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          children: const [
            Center(child: CalendarPage()),
            Center(child: AppartPage()),
            Center(child: SettingsPage()),
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
            icon: const Icon(Icons.settings),
            title: const Center(child: Text("Paramètres")),
            activeColor: Colors.pink,
          ),
        ],
      ),
    );
  }
}
