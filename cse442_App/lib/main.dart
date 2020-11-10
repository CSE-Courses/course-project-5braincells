import 'dart:ui';

import 'package:cse442_App/user_model.dart';

import 'edit_widget.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'nearby_screen.dart';
import 'login_page.dart';
import 'package:flutter/material.dart';
import 'login_or_signup.dart';
import 'user_model.dart';
import 'dart:convert';

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
  final UserModel user;
  MyApp({this.user});

  UserModel getUser() {
    return this.user;
  }

  @override
  State<StatefulWidget> createState() {
    print("This is user in main.dart");
    print(user.id);
    return _MyAppState(user: user);
  }
}

class _MyAppState extends State<MyApp> {
  final UserModel user;
  _MyAppState({this.user});

  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    Widget home = HomeScreen(user: user);
    Widget profile = ProfileScreen(user: user, sameUser: true);
    Widget nearby = NearbyScreen(user: user);

    final _pageOptions = [home, nearby, Text("Bookmarked Page"), profile];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Service App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
          actions: [
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit(user: user)));
                  },
                  child: Icon(Icons.settings),
                ))
          ],
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
                icon: Icon(Icons.location_on), title: Text("Nearby")),
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
