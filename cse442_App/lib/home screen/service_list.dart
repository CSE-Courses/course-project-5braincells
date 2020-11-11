import 'dart:convert';

import 'dart:developer';
import '../nearby screen/googleMaps_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../profile screen/avg.dart';
import '../profile screen/profile_screen.dart';
import '../user model/userListings_model.dart';
import '../user model/user_model.dart';
import 'dart:convert';

class ServiceList extends StatefulWidget {
  final UserModel user;

  const ServiceList({this.user});

  @override
  State<StatefulWidget> createState() {
    return ServiceListState(user);
  }
}

class ServiceListState extends State<ServiceList> {
  final UserModel user;

  ServiceListState(this.user);

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      returnInit();
    });
  }

  int _counter = 0;
  bool sameUser;
  List<UserListingsModel> testingUserList = new List<UserListingsModel>();
  final TextEditingController langaugeController = TextEditingController();

  Future<void> createMydialog(BuildContext context, String description,
      String language, String ownerId) async {
    String toGet = "https://job-5cells.herokuapp.com/getById/" + ownerId;
    var data = await http.get(toGet);
    String username = "";
    UserModel owner;
    if (!data.body.contains("null")) {
      owner = userModelFromJson(data.body);
      print(user.firstname);
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
                            color: Colors.blue,
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

  Widget getInformationBox(
      String jobType,
      String description,
      String dateCreated,
      String owner,
      String language,
      String dist,
      BuildContext context) {
    String finalDescriptionDisplay = "";
    String toRender = "";
    if (description.length < 17) {
      finalDescriptionDisplay = description;
    } else {
      finalDescriptionDisplay = description.substring(0, 17);
    }
    if (dist == null) {
      toRender = "Job Type: " +
          jobType +
          "\n" +
          "Date Created: " +
          dateCreated.substring(0, 16) +
          "\n" +
          "Description: " +
          '\n' +
          finalDescriptionDisplay;
    } else {
      toRender = "Job Type: " +
          jobType +
          "\n" +
          "Date Created: " +
          dateCreated.substring(0, 16) +
          "\n" +
          "Description: " +
          '\n' +
          finalDescriptionDisplay +
          "\nDistance away: " +
          dist;
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
          toRender,
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
    print("Getting listings");

    final String apiUrl = "https://job-5cells.herokuapp.com/allListings";
    final response = await http.get(apiUrl);

    final String temp = response.body;
    return userListingsModelFromJson(temp);
  }

  Future<List<UserListingsModel>> getFilteredListing(String language) async {
    print("Getting Filtered Request");
    if (language != "All") {
      final String apiUrl =
          "https://job-5cells.herokuapp.com/listings/language";
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

  Future<List<UserListingsModel>> getDistanceList(
      List<UserListingsModel> list, double lat, double long) async {
    List<UserListingsModel> listOfLocation = [];
    List<double> listLoc = [];
    for (int i = 0; i < list.length; i++) {
      final String apiUrl =
          "https://job-5cells.herokuapp.com/getById/" + list[i].owner;
      final rep1 = await http.get(apiUrl);
      UserModel aUser = userModelFromJson(rep1.body);
      String aUserlat = aUser.lat.toString();
      String aUserlong = aUser.long.toString();

      if (aUserlat != null && aUserlat != '1.2' && aUserlong != "1.2") {
        final String apiUrl2 =
            "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=" +
                lat.toString() +
                "," +
                long.toString() +
                "&destinations=" +
                aUserlat +
                ',' +
                aUserlong +
                "&key=AIzaSyAYHZdkun8H8EXX9cOnL2BIDybq-reMRss";
        final response = await http.get(apiUrl2);
        Location location = locationFromJson(response.body);
        String loc = (location.rows[0].elements[0].distance.text);
        print("loc = " + loc);
        // double aLoc = double.parse(loc.split(' ')[0]);
        // print("loc = " + aLoc.toString());
        // listLoc.add(aLoc);
        list[i].distAway = loc;
        listOfLocation.add(list[i]);
      }
      print(listLoc);
      //   final response = await http.get(apiUrl2);
      //   Location location = locationFromJson(response.body);
      //   print(location);
      // String loc = (location.rows[0].elements[0].distance.toString());
      // print("loc loc = " + loc);
      // int aLoc = int.parse(loc.split(' ')[0]);
      // print("aloc  = " + aLoc.toString());
      // listLoc.add(aLoc);
      // }
    }
    // print(listLoc);
    return listOfLocation;
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
          title: Text("List of Services"),
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
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () async {
                      testingUserList = await getListing();
                      setState(() {
                        testingUserList = testingUserList;
                      });
                    },
                  ),
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: RaisedButton(
                      elevation: 5.0,
                      onPressed: () async {
                        testingUserList = await getDistanceList(
                            testingUserList, user.lat, user.long);
                        setState(() {
                          testingUserList = testingUserList;
                        });
                      },
                      padding: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue)),
                      color: Colors.white,
                      child: Text(
                        'Get Nearby',
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
                            await getFilteredListing(langaugeController.text);
                        print(langaugeController.text + "/n");
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
                      userListings.distAway,
                      context)
              ]),
            ),
          )
        ]));
  }
}
