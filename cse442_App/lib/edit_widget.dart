import 'package:cse442_App/profile_screen.dart';
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
  bool cityUpdate = false;
  bool passUpdate = false;

  Future<UserModel> updateName(String id, String updateName) async {
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
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserModel> updateLocation(String id, String updateLocation) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/updateLocation";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": id,
          "updateLocation": updateLocation,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserModel> updatePassword(String id, String updatePassword) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/updatePassword";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": id,
          "updatePassword": updatePassword,
        }));
    print(response.body);
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserModel> updateLanguage(String id, String updateLanguage) async {
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
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserModel> updateDescription(
      String id, String updateDescription) async {
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
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<UserModel> updateEmail(String id, String updateEmail) async {
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
    if (response.statusCode == 200) {
      return userModelFromJson(response.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Card(
                        margin: EdgeInsets.all(8.0),
                        color: Colors.blue,
                        elevation: 5,
                        child: ListTile(
                          title: Text(user.firstname,
                              style: TextStyle(color: Colors.white)),
                          trailing: Icon(Icons.edit),
                        )),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Column(
                        children: [
                          ListTile(
                            title: Text("Name"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("New Name"),
                                      content: TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.title),
                                          hintText: "Name",
                                          labelText: "Name",
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
                                      actions: [
                                        RaisedButton(
                                          elevation: 1.0,
                                          onPressed: () async {
                                            final UserModel update =
                                                await updateName(user.id,
                                                    nameController.text);
                                            if (update != null) {
                                              print("worked");
                                              setState(() {
                                                nameUpdate = true;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            user: update)),
                                              );
                                            }
                                          },
                                          child: Text(
                                            'Update!',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12.0,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                            title: Text("Password"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("New Password"),
                                      content: TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.title),
                                          hintText: "Password",
                                          labelText: "Password",
                                        ),
                                        controller: nameController,
                                        maxLength: 75,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter a new password";
                                          }
                                          return null;
                                        },
                                      ),
                                      actions: [
                                        RaisedButton(
                                          elevation: 1.0,
                                          onPressed: () async {
                                            final UserModel updatePass =
                                                await updatePassword(user.id,
                                                    nameController.text);
                                            if (updatePass != null) {
                                              print("worked");
                                              setState(() {
                                                passUpdate = true;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            user: updatePass)),
                                              );
                                            }
                                          },
                                          child: Text(
                                            'Update!',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12.0,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          child: Text(
                                              "Password Update Successful!",
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          visible: passUpdate,
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                              title: Text("Email Address"),
                              trailing: Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("New Email Address"),
                                        content: TextFormField(
                                          decoration: const InputDecoration(
                                            icon: Icon(Icons.email),
                                            hintText: "Email",
                                            labelText: "Email",
                                          ),
                                          controller: emailController,
                                          maxLength: 75,
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return "Please enter a new email address";
                                            }
                                            return null;
                                          },
                                        ),
                                        actions: [
                                          RaisedButton(
                                            elevation: 5.0,
                                            onPressed: () async {
                                              final UserModel updateE =
                                                  await updateEmail(user.id,
                                                      emailController.text);
                                              if (updateE != null) {
                                                print("Email Update worked");
                                                setState(() {
                                                  emailUpdate = true;
                                                });
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProfileScreen(
                                                              user: updateE)),
                                                );
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
                                            child: Text(
                                                "Email Update Successful!",
                                                style: TextStyle(
                                                    color: Colors.blue)),
                                            visible: emailUpdate,
                                          ),
                                        ],
                                      );
                                    });
                              }),
                          ListTile(
                            title: Text("Language"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("New Language"),
                                      content: TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.language_rounded),
                                          hintText: "Language",
                                          labelText: "Language",
                                        ),
                                        controller: languageController,
                                        maxLength: 75,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter a different language";
                                          }
                                          return null;
                                        },
                                      ),
                                      actions: [
                                        RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () async {
                                            final UserModel updateLan =
                                                await updateLanguage(user.id,
                                                    languageController.text);
                                            if (updateLan != null) {
                                              print("Language Update worked");
                                              setState(() {
                                                languageUpdate = true;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            user: updateLan)),
                                              );
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
                                          child: Text(
                                              "Language Update Successful!",
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          visible: languageUpdate,
                                        ),
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                            title: Text("Description"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("New Description"),
                                      content: TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.description),
                                          hintText: "Description",
                                          labelText: "Description",
                                        ),
                                        controller: descriptionController,
                                        maxLength: 75,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter a Description";
                                          }
                                          return null;
                                        },
                                      ),
                                      actions: [
                                        RaisedButton(
                                          elevation: 5.0,
                                          onPressed: () async {
                                            final UserModel updateDes =
                                                await updateDescription(user.id,
                                                    descriptionController.text);
                                            if (updateDes != null) {
                                              print(
                                                  "Description Update worked");
                                              setState(() {
                                                descriptionUpdate = true;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            user: updateDes)),
                                              );
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
                                          child: Text(
                                              "Description Update Successful!",
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          visible: descriptionUpdate,
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                            title: Text("Location"),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("New Location"),
                                      content: TextFormField(
                                        decoration: const InputDecoration(
                                          icon: Icon(Icons.title),
                                          hintText: "Location",
                                          labelText: "Location",
                                        ),
                                        controller: cityController,
                                        maxLength: 75,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return "Please enter a new Name";
                                          }
                                          return null;
                                        },
                                      ),
                                      actions: [
                                        RaisedButton(
                                          elevation: 1.0,
                                          onPressed: () async {
                                            final UserModel updateLoc =
                                                await updateLocation(user.id,
                                                    cityController.text);
                                            if (updateLoc != null) {
                                              print("worked");
                                              setState(() {
                                                cityUpdate = true;
                                              });
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileScreen(
                                                            user: updateLoc)),
                                              );
                                            }
                                          },
                                          child: Text(
                                            'Update!',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12.0,
                                              fontFamily: 'OpenSans',
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                          ),
                          ListTile(
                              title: Text("Update Profile Page"),
                              trailing: Icon(Icons.keyboard_arrow_right))
                        ],
                      ),
                    ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     icon: Icon(Icons.title),
                    //     hintText: "Name",
                    //     labelText: "Name",
                    //   ),
                    //   controller: nameController,
                    //   maxLength: 75,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return "Please enter a new Name";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // RaisedButton(
                    //   elevation: 5.0,
                    //   onPressed: () async {
                    //     final UserModel update =
                    //         await updateName(user.id, nameController.text);
                    //     if (update != null) {
                    //       print("worked");
                    //       setState(() {
                    //         nameUpdate = true;
                    //       });
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 ProfileScreen(user: update)),
                    //       );
                    //     }
                    //   },
                    //   child: Text(
                    //     'Update Name!',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: 12.0,
                    //       fontFamily: 'OpenSans',
                    //     ),
                    //   ),
                    // ),
                    // Visibility(
                    //   child: Text("Name Update Successful!",
                    //       style: TextStyle(color: Colors.blue)),
                    //   visible: nameUpdate,
                    // ),
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     icon: Icon(Icons.title),
                    //     hintText: "Email",
                    //     labelText: "Email",
                    //   ),
                    //   controller: emailController,
                    //   maxLength: 75,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return "Please enter a new Email";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // RaisedButton(
                    //   elevation: 5.0,
                    //   onPressed: () async {
                    //     final UserModel updateE =
                    //         await updateEmail(user.id, emailController.text);
                    //     if (updateE != null) {
                    //       print("Email Update worked");
                    //       setState(() {
                    //         emailUpdate = true;
                    //       });
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 ProfileScreen(user: updateE)),
                    //       );
                    //     }
                    //   },
                    //   child: Text(
                    //     'Update Email!',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: 12.0,
                    //       fontFamily: 'OpenSans',
                    //     ),
                    //   ),
                    // ),
                    // Visibility(
                    //   child: Text("Email Update Successful!",
                    //       style: TextStyle(color: Colors.blue)),
                    //   visible: emailUpdate,
                    // ),
                    // // Description Field
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     icon: Icon(Icons.description),
                    //     hintText: "Description",
                    //     labelText: "Description",
                    //   ),
                    //   controller: descriptionController,
                    //   maxLength: 200,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return "Please enter a Description";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // RaisedButton(
                    //   elevation: 5.0,
                    //   onPressed: () async {
                    //     final UserModel updateDes = await updateDescription(
                    //         user.id, descriptionController.text);
                    //     if (updateDes != null) {
                    //       print("Description Update worked");
                    //       setState(() {
                    //         descriptionUpdate = true;
                    //       });
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 ProfileScreen(user: updateDes)),
                    //       );
                    //     }
                    //   },
                    //   child: Text(
                    //     'Update Description!',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: 12.0,
                    //       fontFamily: 'OpenSans',
                    //     ),
                    //   ),
                    // ),
                    // Visibility(
                    //   child: Text("Description Update Successful!",
                    //       style: TextStyle(color: Colors.blue)),
                    //   visible: descriptionUpdate,
                    // ),
                    // // Language Field
                    // TextFormField(
                    //   decoration: const InputDecoration(
                    //     icon: Icon(Icons.language),
                    //     hintText: "Language",
                    //     labelText: "Language",
                    //   ),
                    //   controller: languageController,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return "Please enter a Language";
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // RaisedButton(
                    //   elevation: 5.0,
                    //   onPressed: () async {
                    //     final UserModel updateLan = await updateLanguage(
                    //         user.id, languageController.text);
                    //     if (updateLan != null) {
                    //       print("Language Update worked");
                    //       setState(() {
                    //         languageUpdate = true;
                    //       });
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 ProfileScreen(user: updateLan)),
                    //       );
                    //     }
                    //   },
                    //   child: Text(
                    //     'Update Language!',
                    //     style: TextStyle(
                    //       color: Colors.blue,
                    //       fontSize: 12.0,
                    //       fontFamily: 'OpenSans',
                    //     ),
                    //   ),
                    // ),
                    // Visibility(
                    //   child: Text("Language Update Successful!",
                    //       style: TextStyle(color: Colors.blue)),
                    //   visible: languageUpdate,
                    // ),
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
                      child: Text("Adding Failed!",
                          style: TextStyle(color: Colors.red)),
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
