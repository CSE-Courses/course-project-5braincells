import 'package:flutter/material.dart';
import '../home screen/home_screen.dart';
import '../main.dart';
import 'login_page.dart';
import 'signup.dart';

class Home extends StatelessWidget {
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Service App"),
          backgroundColor: Colors.blue,
          centerTitle: true),
      body: Column(
        children: <Widget>[
          Text(
            "Welcome to our app!",
            style: TextStyle(
                fontSize: 38,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                height: 3.0),
          ),
          new Padding(
            padding: const EdgeInsets.all(40.0),
          ),
          Center(
            child: ButtonTheme(
              height: 60,
              minWidth: 125,
              child: RaisedButton(
                elevation: 5.0,
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'san-serif',
                    color: Colors.lightBlue,
                  ),
                ),
              ),
            ),
          ),
          Center(
            heightFactor: 1.5,
            child: ButtonTheme(
              height: 60,
              minWidth: 125,
              child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'san-serif',
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.lightBlue),
            ),
          ),
        ],
      ),
    );
  }
}
