import 'package:flutter/material.dart';

class NewListing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NewListingState();
  }
}

class NewListingState extends State<NewListing> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

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
                    child: Text("Submit"),
                  ),
                ),
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
