import 'package:flutter/material.dart';
import '../home screen/home_screen.dart';
import '../main.dart';
import 'login_page.dart';
import 'signup.dart';

class Forgot extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Forgot Email/Password"),
          backgroundColor: Colors.blue,
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            Container(
                child: Text(
              "Forgot Password",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
            new Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            // Text(
            //   "Enter Forgotten Email",
            //   style: TextStyle(fontSize: 18),
            // ),
            Container(
                width: 300.0,
                child: TextField(
                  decoration: new InputDecoration(hintText: "Enter email"),
                  controller: emailController,
                )),
            Center(
              heightFactor: 2,
              child: ButtonTheme(
                height: 50,
                minWidth: 150,
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        fontFamily: 'san-serif',
                        color: Colors.white,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            Center(
              child: ButtonTheme(
                height: 50,
                minWidth: 150,
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
                          fontSize: 18),
                    ),
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
