import 'dart:convert';

import 'package:cse442_App/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'avg.dart';
import 'profile_screen.dart';
import 'userListings_model.dart';

class RequestList extends StatefulWidget {
  final UserModel user;

  const RequestList({this.user});
  @override
  State<StatefulWidget> createState() {
    return RequestListState(user);
  }
}

class RequestListState extends State<RequestList> {
  String _currentState = 'All';
  var _statesList1 = ['German', 'English', 'Chinese', 'Korean'];
  final _formKey = GlobalKey<FormState>();
  int _dropDownButtonValue = 1;

  final UserModel user;
  RequestListState(this.user);

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnInit();
    });
  }

  bool sameUser;

  final TextEditingController langaugeController = TextEditingController();
  int _counter = 0;
  List<UserListingsModel> testingUserList = new List<UserListingsModel>();

  Future<void> createMydialog(BuildContext context, String description,
      String language, String ownerId) async {
    String toGet = "https://job-5cells.herokuapp.com/getById/" + ownerId;
    var data = await http.get(toGet);
    String username = "";
    UserModel owner;
    if (!data.body.contains("null")) {
      owner = userModelFromJson(data.body);
      //print(user.firstname);
      username = owner.firstname;
      if (ownerId == user.id) {
        print(ownerId);
        print(user.id);
        sameUser = true;
      } else {
        sameUser = false;
      }
    }
    double stars = 0.0;
    String ratingURL =
        "https://job-5cells.herokuapp.com/getAvgStars/" + ownerId;
    var ratingData = await http.get(ratingURL);
    if (!ratingData.body.contains("null")) {
      Avg avg = avgFromJson(ratingData.body);
      if (avg != null) {
        stars = avg.avg;
      }
    }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Description"),
            content: SingleChildScrollView(
                child: ListBody(
              children: [
                Text(description),
                SizedBox(
                  height: 10,
                ),
                Text("Preferred language: " + language),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                    child: SizedBox(
                      child: Container(
                        child: Text(
                          'By: ' + username,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(user: owner, sameUser: sameUser)),
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                Text("Rating: " + stars.toString())
              ],
            )),
          );
        });
  }

  Widget getInformationBox(String jobType, String description,
      String dateCreated, String owner, String language, BuildContext context) {
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
          createMydialog(context, description, language, owner);
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
                      userListings.createdAt.toString(),
                      userListings.owner,
                      userListings.language.toString(),
                      context)
              ]),
            ),
          )
        ]));
  }
}
