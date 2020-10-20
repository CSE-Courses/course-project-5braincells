import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_model.dart';

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

/*
  New Listing Widget to be used to create a new listing.
  This widget will contain a form to add a new listing.
*/
class NewListingState extends State<NewListing> {
  final UserModel user;
  NewListingState({this.user});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  bool added = false;
  bool failed = false;

  int _dropDownButtonValue = 1;
  String _currentState = 'AK';
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

  Widget addBtn() {
    return Container(
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          if (titleController.text == "" ||
              languageController.text == "" ||
              descriptionController.text == "") {
            setState(() {
              failed = true;
            });
          } else {
            final String user = await addListing(
                titleController.text,
                languageController.text,
                this.user.id,
                descriptionController.text);
            if (user != null) {
              titleController.text = "";
              languageController.text = "";
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
        },
        child: Text(
          'Add Listing!',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 12.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

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

                // Language Field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.language),
                    hintText: "Listing Language",
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

                // State Dropdown Menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(Icons.place),
                        Text(
                          "State",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
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
                  ],
                ),

                // Type of Listing Dropdown Menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      "Type of Listing",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    DropdownButton(
                      value: _dropDownButtonValue,
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
                          _dropDownButtonValue = newDropDownButtonValue;
                        });
                      },
                    ),
                  ],
                ),

                // Submit button with SnackBar
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text("Creating Listing"),
                        ));
                      }
                    },
                    child: addBtn(),
                  ),
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
