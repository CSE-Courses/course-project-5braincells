import 'dart:ui';

import 'package:cse442_App/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int _selectedPage = 0;
  final _pageOptions = [
    HomeScreen(),
    Text("Trending Page"),
    Text("Calendar Page"),
    Text("Bookmarked Page"),
    Text("Profile Page")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Service App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up), title: Text("Trending")),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), title: Text("Calendar")),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border), title: Text("Bookmark")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Profile")),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.blue[100],
        ),
      ),
    );
  }
}
