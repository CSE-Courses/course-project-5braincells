import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'main.dart';
import 'user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'forgot_pass_email.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginScreenState();
  }
}

bool failedLogin = false;

Future<UserModel> login(String _email, String _password) async {
  print("Create User is called");

  final String apiUrl = "https://job-5cells.herokuapp.com/login";
  final response = await http.post(apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "password": _password,
        "email": _email,
      }));
  print(response.body);
  if (response.statusCode == 200) {
    final String resString = response.body;
    return userModelFromJson(resString);
  } else {
    return null;
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget _emailinput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email'),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: (TextStyle(color: Colors.black)),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email), hintText: 'Enter your email'),
            controller: emailController,
          ),
        )
      ],
    );
  }

  Widget _passwordinput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password'),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            obscureText: true,
            keyboardType: TextInputType.emailAddress,
            style: (TextStyle(color: Colors.black)),
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock), hintText: 'Password'),
            controller: passwordController,
          ),
        )
      ],
    );
  }

  Widget _LoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: 140.0,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          print(emailController.text);
          print(passwordController.text);
          final UserModel user =
              await login(emailController.text, passwordController.text);
          if (user != null) {
            print(user);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp(user: user)),
            );
          } else {
            setState(() {
              failedLogin = true;
            });
          }
        },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Forgot()),
          );
        },

        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
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
        body: Stack(
          children: <Widget>[
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
                    Text(
                      'Sign in',
                      style: TextStyle(color: Colors.blue, fontSize: 40.0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.0),
                    _emailinput(),
                    SizedBox(height: 30.0),
                    _passwordinput(),
                    Visibility(
                      child: Text("Email or Password is Incorrect",
                          style: TextStyle(color: Colors.red)),
                      visible: failedLogin,
                    ),
                    _LoginBtn(),
                    _forgotPassword(),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
