import 'package:flutter/material.dart';
import 'home_page.dart';
import 'old_testament_page.dart';
import 'new_testament_page.dart';

void main() {
  runApp(BibleTrackerApp());
}

class BibleTrackerApp extends StatefulWidget {
  @override
  _BibleTrackerAppState createState() => _BibleTrackerAppState();
}

class _BibleTrackerAppState extends State<BibleTrackerApp> {
  int _selectedIndex = 1; // Home is the default page

  final List<Widget> _pages = [
    OldTestamentPage(),
    HomePage(),
    NewTestamentPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bible Tracker',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.grey[900], // Set background color to darkGray
          selectedItemColor: Colors.tealAccent, // Set selected item color to teal
          unselectedItemColor:
              Colors.grey[200], // Set unselected item color to lightGray
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Old Testament",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.auto_stories),
              label: "New Testament",
            ),
          ],
        ),
      ),
    );
  }
}
