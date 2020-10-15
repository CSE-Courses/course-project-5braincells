import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main.dart';
import 'Login_page.dart';
import 'signup.dart';

class Forgot extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Forgot Email/Password"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true),
      body: Column(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(20.0),
          ),
          Container(
              child: Text("Forgot Password", style: TextStyle(fontSize: 20))),
          new Padding(
            padding: const EdgeInsets.all(20.0),
          ),
          Text("Enter Email"),
          Container(
              width: 300.0,
              child: TextField(
                controller: emailController,
              )),
          Center(
              child: RaisedButton(
            elevation: 5.0,
            color: Colors.blue,
            onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text(
              'Submit',
              style: TextStyle(
                fontFamily: 'san-serif',
                color: Colors.white,
              ),
            ),
          )),
          Center(
            child: RaisedButton(
                elevation: 5.0,
                onPressed: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => SignUp()));
                },
                child: Text(
                  'Forgot Email',
                  style: TextStyle(
                    fontFamily: 'san-serif',
                    color: Colors.lightBlue,
                  ),
                ),
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
