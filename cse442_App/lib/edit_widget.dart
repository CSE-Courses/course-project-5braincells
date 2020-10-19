import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

class Edit extends StatefulWidget {
  final UserModel user;
  Edit({this.user});

  @override
  State<StatefulWidget> createState() {
    print(user);
    // TODO: implement createState
    return EditState(user: user);
  }
}

class EditState extends State<Edit> {
  final UserModel user;
  EditState({this.user});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool added = false;
  bool failed = false;
  bool nameUpdate = false;
  bool emailUpdate = false;
  bool descriptionUpdate = false;
  bool languageUpdate = false;

  Future<bool> updateName(String id, String updateName) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/updateName";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": id,
          "updateName": updateName,
        }));
    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool> updateLanguage(String id, String updateLanguage) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/updateLanguage";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": id,
          "updateLanguage": updateLanguage,
        }));
    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool> updateDescription(String id, String updateDescription) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/updateDescription";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": id,
          "updateDescription": updateDescription,
        }));
    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else {
      return null;
    }
  }

  Future<bool> updateEmail(String id, String updateEmail) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/updateEmail";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": id,
          "updateEmail": updateEmail,
        }));
    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        body: Builder(
      builder: (context) => Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            // Title Field
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                hintText: "First Name",
                labelText: "First Name",
              ),
              controller: nameController,
              maxLength: 75,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a new Name";
                }
                return null;
              },
            ),
            RaisedButton(
              elevation: 5.0,
              onPressed: () async {
                final bool update =
                    await updateName(user.id, nameController.text);
                if (update) {
                  print("worked");
                  setState(() {
                    nameUpdate = true;
                  });
                }
              },
              child: Text(
                'Update Name!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Visibility(
              child: Text("Name Update Successful!",
                  style: TextStyle(color: Colors.blue)),
              visible: nameUpdate,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.title),
                hintText: "Email",
                labelText: "Email",
              ),
              controller: emailController,
              maxLength: 75,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a new Email";
                }
                return null;
              },
            ),
            RaisedButton(
              elevation: 5.0,
              onPressed: () async {
                final bool updateE =
                    await updateEmail(user.id, emailController.text);
                if (updateE) {
                  print("Email Update worked");
                  setState(() {
                    emailUpdate = true;
                  });
                }
              },
              child: Text(
                'Update Email!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Visibility(
              child: Text("Email Update Successful!",
                  style: TextStyle(color: Colors.blue)),
              visible: emailUpdate,
            ),
            // Description Field
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: "Description",
                labelText: "Description",
              ),
              controller: descriptionController,
              maxLength: 200,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a Description";
                }
                return null;
              },
            ),
            RaisedButton(
              elevation: 5.0,
              onPressed: () async {
                final bool updateDes = await updateDescription(
                    user.id, descriptionController.text);
                if (updateDes) {
                  print("Description Update worked");
                  setState(() {
                    descriptionUpdate = true;
                  });
                }
              },
              child: Text(
                'Update Description!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Visibility(
              child: Text("Description Update Successful!",
                  style: TextStyle(color: Colors.blue)),
              visible: descriptionUpdate,
            ),
            // Language Field
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.language),
                hintText: "Language",
                labelText: "Language",
              ),
              controller: languageController,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter a Language";
                }
                return null;
              },
            ),
            RaisedButton(
              elevation: 5.0,
              onPressed: () async {
                final bool updateLan =
                    await updateLanguage(user.id, languageController.text);
                if (updateLan) {
                  print("Language Update worked");
                  setState(() {
                    languageUpdate = true;
                  });
                }
              },
              child: Text(
                'Update Language!',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12.0,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            Visibility(
              child: Text("Language Update Successful!",
                  style: TextStyle(color: Colors.blue)),
              visible: languageUpdate,
            ),
            // City Field

            // State Dropdown Menu

            // Type of Listing Dropdown Menu

            // Submit button with SnackBar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            Visibility(
              child: Text("Listing Added!",
                  style: TextStyle(color: Colors.lightBlue)),
              visible: added,
            ),
            Visibility(
              child:
                  Text("Adding Failed!", style: TextStyle(color: Colors.red)),
              visible: failed,
            )
          ]),
        ),
      ),
    ));
  }

  // ScaffoldFeatureController<SnackBar, SnackBarClosedReason> mySnackBar() {
  //   return Scaffold.of(context)
  //       .showSnackBar(SnackBar(content: Text("Processing data")));
  // }
}
