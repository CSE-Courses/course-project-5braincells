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
  int _dropDownButtonValue = 1;

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
                    icon: Icon(Icons.description),
                    hintText: "Listing Title",
                    labelText: "Title",
                  ),
                  maxLength: 75,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a Title";
                    }
                    return null;
                  },
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
                      onChanged: (dropDownButtonValue) {
                        setState(() {
                          _dropDownButtonValue = dropDownButtonValue;
                        });
                      },
                    ),
                  ],
                ),
                // Description Field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: "Listing Description",
                    labelText: "Description",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a Description";
                    }
                    return null;
                  },
                ),
                // ZIP Code Field
                TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.description),
                    hintText: "Listing ZIP Code",
                    labelText: "ZIP Code",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter a Title";
                    }
                    return null;
                  },
                ),

                // Submit
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
                // Add TextFormFields and ElevatedButton here.
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
