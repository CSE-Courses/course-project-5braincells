import 'package:flutter/material.dart';
import 'package:Flutter_complete_testing/home_screen.dart';
import 'package:Flutter_complete_testing/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {

  Widget _emailinput() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text('Email'),
      SizedBox(height:10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: TextField(keyboardType: TextInputType.emailAddress,
          style: (TextStyle(color: Colors.black)),
          decoration: InputDecoration(prefixIcon: Icon(Icons.email), hintText: 'Enter your email'),
        ),
      )
    ],);
  }

  Widget _passwordinput() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
      Text('Password'),
      SizedBox(height:10.0),
      Container(
        alignment: Alignment.centerLeft,
        height: 60.0,
        child: TextField(obscureText: true, keyboardType: TextInputType.emailAddress,
          style: (TextStyle(color: Colors.black)),
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock), hintText: 'Password'),
        ),
      )
    ],);
  }

  Widget _LoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 140.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue)
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 220.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {},
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue)
        ),
        color: Colors.white,
        child: Text(
          'Forgot Email or Password?',
          style: TextStyle(
            color: Colors.blue,
            letterSpacing: 1.0,
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Service App"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
      body:Stack(
        children: <Widget> [
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 80.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Sign in',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40.0
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                _emailinput(),
                SizedBox(height: 30.0),
                _passwordinput(),
                _LoginBtn(),
                _forgotPassword(),
              ],
            ),
          ),
          ),
        ],
      )
    );
  }
}
