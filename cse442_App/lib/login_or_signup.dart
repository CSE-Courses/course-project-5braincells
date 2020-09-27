import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main.dart';
import 'Login_page.dart';
import 'signup.dart';
class Home extends StatelessWidget{
  @override
  Widget build(context){
    return Scaffold(
      appBar: AppBar(
        title : Text('Log in or Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.blue[200],
      ),
      body: Column(
            
              children: <Widget>[
                new Padding(
                padding: const EdgeInsets.all(100.0),
              ),
                Center(
                    child: RaisedButton(
                  onPressed: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                  },
                  child : Text('Log In'),
                  color : Colors.lightBlue[200]
                )
                ),
                Center(
                    child : RaisedButton(
                  onPressed: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignUp()));
                  },
                  child : Text('Sign up'),
                  color : Colors.lightBlue[200]
                ),
                ),
                
              ],
            ),
    );
  }
}