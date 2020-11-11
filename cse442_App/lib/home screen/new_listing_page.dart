import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../user model/user_model.dart';

class NewListing extends StatefulWidget {
  final UserModel user;
  NewListing({this.user});

  @override
  State<StatefulWidget> createState() {
    print(user);
    // TODO: implement createState
    return NewListingState(user: user);
  }
}

class NewListingState extends State<NewListing> {
  final UserModel user;
  NewListingState({this.user});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  // final TextEditingController languageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool added = false;
  bool failed = false;

  int _dropDownStateValue = 1;
  String _currentState = 'AK';
  String _currentLanguage = "English";

  var _statesList = [
    'AK',
    'AL',
    'AR',
    'AS',
    'AZ',
    'CA',
    'CO',
    'CT',
    'DC',
    'DE',
    'FL',
    'GA',
    'GU',
    'HI',
    'IA',
    'ID',
    'IL',
    'IN',
    'KS',
    'KY',
    'LA',
    'MA',
    'MD',
    'ME',
    'MI',
    'MN',
    'MO',
    'MP',
    'MS',
    'MT',
    'NC',
    'ND',
    'NE',
    'NH',
    'NJ',
    'NM',
    'NV',
    'NY',
    'OH',
    'OK',
    'OR',
    'PA',
    'PR',
    'RI',
    'SC',
    'SD',
    'TN',
    'TX',
    'UM',
    'UT',
    'VA',
    'VI',
    'VT',
    'WA',
    'WI',
    'WV',
    'WY'
  ];

  var _topLanguages = [
    'English',
    'Spanish',
    'Arabic',
    'Armenian',
    'Bengali',
    'Cantonese',
    'Creole',
    'Croatian',
    'French',
    'German',
    'Greek',
    'Gujarati',
    'Hebrew',
    'Hindi',
    'Italian',
    'Japanese',
    'Korean',
    'Mandarin',
    'Persian',
    'Polish',
    'Portuguese',
    'Punjabi',
    'Russian',
    'Serbian',
    'Tagalog',
    'Tai–Kadai',
    'Tamil',
    'Telugu',
    'Urdu',
    'Vietnamese',
    'Yiddish',
    'Pig Latin'
  ];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
        appBar: AppBar(
          title: Text("Create New Listing"),
        ),
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                // Title Field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.title),
                    hintText: "Listing Title",
                    labelText: "Title",
                  ),
                  controller: titleController,
                  maxLength: 75,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a Title";
                    }
                    return null;
                  },
                ),
                // Description Field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: "Listing Description",
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
                // City Field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.location_city),
                    hintText: "Listing City",
                    labelText: "City",
                  ),
                  controller: cityController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a City";
                    }
                    return null;
                  },
                ),
                // Row containing Language Field, State Field, Type of Listing Field, and All Dropdown Menus.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First Column containing Language, State, and Type of Listing
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // State Field
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Icon(Icons.place),
                              Text(
                                "State",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Language Field
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Icon(Icons.language),
                              Text(
                                "Language",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Type of Listing Field
                        Padding(
                          padding: EdgeInsets.all(15),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Icon(Icons.content_paste),
                              Text(
                                "Type of Listing",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Second Column containing Language Dropdown, State Dropdown, and Type of Listing Dropdown Menu
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // State Dropdown Menu
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 5, 15),
                          child: DropdownButton<String>(
                            items: _statesList.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (newStateSelected) {
                              setState(() {
                                this._currentState = newStateSelected;
                              });
                            },
                            value: _currentState,
                          ),
                        ),
                        // Language Dropdown Menu
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 5, 15),
                          child: DropdownButton<String>(
                            items:
                                _topLanguages.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: (newLanguageSelected) {
                              setState(() {
                                this._currentLanguage = newLanguageSelected;
                              });
                            },
                            value: _currentLanguage,
                          ),
                        ),
                        // Type of Listing Dropdown Menu
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 15, 5, 15),
                          child: DropdownButton(
                            value: _dropDownStateValue,
                            items: [
                              DropdownMenuItem(
                                child: Text("Service"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text("Request"),
                                value: 2,
                              ),
                            ],
                            onChanged: (newDropDownButtonValue) {
                              setState(() {
                                _dropDownStateValue = newDropDownButtonValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // Padding for Add Listing Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: addBtn(),
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

  // Add Listing Button
  Widget addBtn() {
    return Container(
      // Added Button Theme to increase button size
      child: ButtonTheme(
        minWidth: 120,
        height: 50,
        // Add Listing Button
        child: RaisedButton(
          elevation: 5.0,
          color: Colors.white,
          onPressed: () async {
            if (_dropDownStateValue == 1) {
              if (titleController.text == "" ||
                  descriptionController.text == "") {
                setState(() {
                  failed = true;
                });
              } else {
                print("Added Service");
                final String user = await addListing(titleController.text,
                    _currentLanguage, this.user.id, descriptionController.text);
                if (user != null) {
                  titleController.text = "";
                  descriptionController.text = "";
                  setState(() {
                    added = true;
                  });
                } else {
                  setState(() {
                    failed = true;
                  });
                }
              }
            }
            // Adds listing to Request
            else {
              if (titleController.text == "" ||
                  descriptionController.text == "") {
                setState(() {
                  failed = true;
                });
              } else {
                print("Added Request");
                final String user = await addRequestListing(
                    titleController.text,
                    _currentLanguage,
                    this.user.id,
                    descriptionController.text);
                if (user != null) {
                  titleController.text = "";
                  descriptionController.text = "";
                  setState(() {
                    added = true;
                  });
                } else {
                  setState(() {
                    failed = true;
                  });
                }
              }
            }
          },
          child: Text(
            'Add Listing!',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16.0,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  // Function for adding a Service to the database
  Future<String> addListing(
      String jobType, String language, String id, String description) async {
    print("Adding List is called");

    final String apiUrl = "https://job-5cells.herokuapp.com/addListing";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "jobType": jobType,
          "user_id": id,
          "language": language,
          "description": description
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final String resString = response.body;
      return (resString);
    } else {
      return null;
    }
  }

  // Function for adding a Request to the database
  Future<String> addRequestListing(
      String jobType, String language, String id, String description) async {
    print("Adding List is called");

    final String apiUrl = "https://job-5cells.herokuapp.com/addRequest";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "jobType": jobType,
          "user_id": id,
          "language": language,
          "description": description
        }));
    print(response.body);
    if (response.statusCode == 200) {
      final String resString = response.body;
      return (resString);
    } else {
      return null;
    }
  }
}
