import 'dart:ui';

import 'home_screen.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import 'login_or_signup.dart';
import 'profile_screen.dart';

void main() {
  runApp(MyAppTest());
}

class MyAppTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginScreen(),
      home: Home(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
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
    ProfileScreen()
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
