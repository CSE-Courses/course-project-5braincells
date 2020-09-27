import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  String _name;
  String _email;
  String _password;
  String _location;
  String _phoneNumber;
  bool _obscureText = true;

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
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required *';
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
            .hasMatch(value)) {
          return "Please nter a valid email address.";
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
                  SizedBox(height: 100, width: 60),
                  RaisedButton(
                    child: Text("Sign up",
                        style: TextStyle(
                            fontFamily: 'san-serif',
                            color: Colors.lightBlue,
                            fontSize: 16)),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                        side: BorderSide(color: Colors.blueAccent)),
                    onPressed: () {
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      _formKey.currentState.save();
                      print(_name);
                    },
                  )
                ],
              ))),
    );
  }
}
