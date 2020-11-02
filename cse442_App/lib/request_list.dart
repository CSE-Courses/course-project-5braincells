import 'dart:convert';

import 'package:cse442_App/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'userListings_model.dart';

class RequestList extends StatefulWidget {
  @override
  RequestListState createState() => RequestListState();
}

final TextEditingController langaugeController = TextEditingController();
int _counter = 0;
List<UserListingsModel> testingUserList = new List<UserListingsModel>();

Widget getInformationBox(
    String jobType, String description, String dateCreated) {
  String finalDescriptionDisplay = "";
  if (description.length < 17) {
    finalDescriptionDisplay = description;
  } else {
    finalDescriptionDisplay = description.substring(0, 17);
  }

  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    alignment: Alignment.topLeft,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: () {
        print('something');
      },
      padding: const EdgeInsets.only(
          bottom: 10.0, left: 20.0, right: 60.0, top: 10.0),
      shape: RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
      color: Colors.white,
      child: Text(
        "Job Type: " +
            jobType +
            "\n" +
            "Date Created: " +
            dateCreated.substring(0, 16) +
            "\n" +
            "Description: " +
            finalDescriptionDisplay,
        style: TextStyle(
          color: Colors.black,
          letterSpacing: 1.2,
          fontSize: 15.0,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}

/*
  Request List Widget to be used when the "Requests" button is tapped.
  This widget will a list of service requests from users.
*/
class RequestListState extends State<RequestList> {
  String _currentState = 'All';
  var _statesList1 = ['German', 'English', 'Chinese', 'Korean'];
  final _formKey = GlobalKey<FormState>();
  int _dropDownButtonValue = 1;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnInit();
    });
  }

  Future<List<UserListingsModel>> getListing() async {
    print("Getting Request");

    final String apiUrl = "https://job-5cells.herokuapp.com/allRequest";
    final response = await http.get(apiUrl);

    final String temp = response.body;
    return userListingsModelFromJson(temp);
  }

  Future<List<UserListingsModel>> getFilteredRequest(String language) async {
    print("Getting Filtered Request");
    if (language != "All") {
      final String apiUrl =
          "https://job-5cells.herokuapp.com/requests/language";
      final response = await http.post(apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({"language": language}));

      final String temp = response.body;
      return userListingsModelFromJson(temp);
    } else {
      return null;
    }
  }

  void returnInit() async {
    List<UserListingsModel> temporaryList = await getListing();
    setState(() {
      testingUserList = temporaryList;
      for (var userListings in testingUserList)
        print(userListings.jobType.toString() +
            ", " +
            userListings.description.toString() +
            "\n");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("List of Request"),
          centerTitle: true,
        ),
        body: Stack(children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 40.0,
              ),
              child: Column(children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {
                        setState(() {});
                        testingUserList = await getListing();
                      },
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      color: Colors.white,
                      child: Text(
                        'refresh',
                        style: TextStyle(
                          color: Colors.blue,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )),
                Text("Filter by Language"),
                Container(
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: new Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: new TextField(
                    controller: langaugeController,
                    textAlign: TextAlign.center,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {
                        List<UserListingsModel> toUpdate =
                            await getFilteredRequest(langaugeController.text);
                        print(toUpdate);
                        setState(() {
                          testingUserList = toUpdate;
                        });
                      },
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      color: Colors.white,
                      child: Text(
                        'Get Listings',
                        style: TextStyle(
                          color: Colors.blue,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    )),
                SizedBox(height: 30.0),
                for (var userListings in testingUserList)
                  getInformationBox(
                      userListings.jobType.toString(),
                      userListings.description.toString(),
                      userListings.createdAt.toString())
              ]),
            ),
          )
        ]));
  }
}
