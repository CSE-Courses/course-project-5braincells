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

  Widget emailInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        style: (TextStyle(color: Colors.black)),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.email),
            hintText: 'Enter your email',
            labelText: 'Email',
        ),
        controller: emailController,
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.text,
        style: (TextStyle(color: Colors.black)),
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock),
            hintText: 'Enter your password',
            labelText: 'Password',
        ),
        controller: passwordController,
      ),
    );
  }

  Widget loginBtn() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 50,
        child: RaisedButton(
          elevation: 5,
          color: Colors.white,
          child: Text(
            "Login",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontFamily: 'OpenSans'
            ),
          ),
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
            }},
        ),
      ),
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: EdgeInsets.all(10),
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
          children: [
            Builder(
              builder: (context) => Form(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(10),
                          child:   Text('Sign in',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 40.0
                            ),
                          )
                      ),
                      emailInput(),
                      passwordInput(),
                      Visibility(
                        child: Text("Email or Password is Incorrect",
                            style: TextStyle(color: Colors.red)),
                        visible: failedLogin,
                      ),
                      forgotPassword(),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: loginBtn(),
            ),
          ],
        )
    );
  }
}
