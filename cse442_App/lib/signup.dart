import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main.dart';
import 'user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

bool failedSignUp = false;
Future<UserModel> createUser(String _name, String _email, String _password,
    String _location, String _phoneNumber) async {
  print("Create User is called");

  final String apiUrl = "https://job-5cells.herokuapp.com/signup";
  final response = await http.post(apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        "firstname": _name,
        "password": _password,
        "email": _email,
        "phone": _phoneNumber,
        "location": _location
      }));
  print(response.body);
  if (response.statusCode == 201) {
    final String resString = response.body;
    return userModelFromJson(resString);
  } else {
    return null;
  }
}

class SignUpState extends State<SignUp> {
  String _name;
  String _email;
  String _password;
  String _location;
  String _phoneNumber;
  bool _obscureText = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "Full Name",
          focusColor: Colors.blue,
          icon: Icon(Icons.person),
          labelText: 'Name',
          fillColor: Colors.blue),
      controller: nameController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required *';
        }
      },
      onSaved: (String value) {
        _name = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "app@example.com",
          icon: Icon(Icons.email),
          labelText: 'Email Address'),
      controller: emailController,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required *';
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return "Valid email address required *";
        }
        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    // new FlatButton(
    //     onPressed: _toggle(), child: new Text(_obscureText ? "Show" : "Hide"));
    return new TextFormField(
      controller: passwordController,
      obscureText: _obscureText,
      keyboardType: TextInputType.visiblePassword,
      decoration:
          InputDecoration(icon: Icon(Icons.lock), labelText: 'Password'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is Required *';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildLocation() {
    return TextFormField(
      controller: locationController,
      decoration: InputDecoration(
          hintText: "City, State",
          icon: Icon(Icons.location_city),
          labelText: 'Location'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location is Required *';
        }
      },
      onSaved: (String value) {
        _location = value;
      },
    );
  }

  Widget _buildPhone() {
    return TextFormField(
      controller: phoneController,
      decoration: InputDecoration(
          icon: Icon(Icons.contact_phone), labelText: 'Phone Number'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone Number is Required *';
        }
      },
      onSaved: (String value) {
        _phoneNumber = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
          title: Text("Service App"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new Align(
                  alignment: Alignment.center,
                  child: Text("Sign up an account",
                      style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'sans-serif',
                          fontSize: 22)),
                ),
                _buildName(),
                _buildEmail(),
                _buildPassword(),
                _buildLocation(),
                _buildPhone(),
                Visibility(
                  child: Text("Email already in use",
                      style: TextStyle(color: Colors.red)),
                  visible: failedSignUp,
                ),
                SizedBox(height: 20, width: 100),
                RaisedButton(
                  padding: EdgeInsets.all(20),
                  elevation: 5.0,
                  child: Text("Sign up",
                      style: TextStyle(
                          fontFamily: 'san-serif',
                          color: Colors.lightBlue,
                          fontSize: 18)),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                      side: BorderSide(color: Colors.blueAccent)),
                  onPressed: () async {
                    final name = nameController.text;
                    final email = emailController.text;
                    final password = passwordController.text;
                    final location = locationController.text;
                    final phoneNumber = phoneController.text;
                    print(name);
                    final UserModel user = await createUser(
                        name, email, password, location, phoneNumber);
                    print(user);

                    if (user != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                      print("Worked");
                    } else {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      setState(() {
                        failedSignUp = true;
                      });
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
