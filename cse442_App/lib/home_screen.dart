import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'dart:math';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';

import 'service_list.dart';
import 'request_list.dart';
import 'user_model.dart';
import 'new_listing_page.dart';
import 'package:cse442_App/user_model.dart';
import 'search_bar.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  HomeScreen({this.user});
  @override
  State<StatefulWidget> createState() {
    /*  */
    // TODO: implement createState
    return HomeScreenState(user: user);
  }
}

// Used to send verification email to user to add verification badge to their profile.
Future<bool> sendVerifyEmail(String _userId, String _email) async {
  print("Sending Verification Email");

  final String apiUrl = "https://job-5cells.herokuapp.com/verify";
  final response = await http.post(apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({"userId": _userId, "email": _email}));
  print(response.body);
  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

/*
  Home Screen Widget to be used when in the "Home" tab of the Navigation bar.
  This widget will contain the Search Bar used to find listings within the app.
*/
class HomeScreenState extends State<HomeScreen> {
  final UserModel user;
  HomeScreenState({this.user});
  bool pressON = false;
  bool _firstPress = true;
  String location;
  Position _userPos;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  // Used in search bar
  bool isReplay = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getLocation();
    });
  }

  // Obtains current location from the user's device (if enabled)
  void getLocation() async {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      print(position);
      final String location =
          await _getAddressFromLatLng(position.latitude, position.longitude);
      print(location);
      final String apiUrl = "https://job-5cells.herokuapp.com/update/location";
      final response = await http.post(apiUrl,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode({
            "userId": user.id,
            "lat": position.latitude,
            "long": position.longitude,
            "location": location
          }));

      setState(() {
        _userPos = position;
        user.lat = position.latitude;
        user.long = position.longitude;
        user.location = location;
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<String> _getAddressFromLatLng(double lat, double long) async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(lat, long);

      Placemark place = p[0];
      print("place" + place.toString());
      return "${place.locality}, ${place.postalCode}, ${place.country}";
    } catch (e) {
      print(e);
    }
  }

  // Main build function of home screen
  Widget build(BuildContext context) {
    print(user);
    print(user.verify);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // Flappy Search Bar
          Padding(
            padding: EdgeInsets.fromLTRB(50, 20, 50, 10),
            child: RaisedButton(
              child: Container(
                height: 55,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.cyanAccent,
                    Colors.lightBlue,
                    Colors.blue,
                    Colors.lightBlue,
                    Colors.cyanAccent,
                  ]),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                    Text(
                      "Search for Listings",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FlapSearchBar(user: user)));
              },
            ),
          ),

          // First Row of Buttons (Services / Requests)
          ButtonBar(
            buttonPadding: EdgeInsets.all(12),
            alignment: MainAxisAlignment.center,
            buttonHeight: 75,
            buttonMinWidth: 150,
            children: <Widget>[
              RaisedButton(
                color: Colors.lightBlueAccent,
                child: Text(
                  "Services",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.lightBlue, width: 2.0)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceList(user: user)));
                },
              ),
              RaisedButton(
                color: Colors.lightBlueAccent,
                child: Text(
                  "Requests",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                    side: BorderSide(color: Colors.lightBlue, width: 2.0)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RequestList(user: user)));
                },
              ),
            ],
          ),
          // Second Row of Buttons (Tutoring / Transport / Services)
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 100.0,
            buttonHeight: 100.0,
            children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Text("Baby Sitting"),
                onPressed: () => "CLICK",
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text("Cleaning"),
                onPressed: () => "CLICK",
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text("Construction"),
                onPressed: () => "CLICK",
              ),
            ],
          ),
          // Third Row of Buttons (Ex.4 / Ex.5 / Ex.6)
          ButtonBar(
            alignment: MainAxisAlignment.center,
            buttonMinWidth: 100.0,
            buttonHeight: 100.0,
            children: <Widget>[
              RaisedButton(
                color: Colors.blue,
                child: Text("Tutoring"),
                onPressed: () => "CLICK",
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text("Transport"),
                onPressed: () => "CLICK",
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text("Barber"),
                onPressed: () => "CLICK",
              ),
            ],
          ),
          // Email Verification Banner
          if (user.verify == null || user.verify == false)
            Container(
              alignment: Alignment.center,
              child: Text(
                "Your email has not been verified",
                style: TextStyle(color: Colors.red),
              ),
            ),
          // Email button to send email verification link
          if (user.verify == null || user.verify == false)
            Container(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                width: 0.0,
                child: RaisedButton(
                  elevation: 5.0,
                  child: pressON
                      ? Text("Verification Email has been sent.")
                      : Text("Click here to send verification email."),
                  onPressed: () async {
                    if (_firstPress) {
                      print(user.id);
                      print(user.email);
                      final bool emailSent = await sendVerifyEmail(
                          user.id.toString(), user.email.toString());
                      print(emailSent.toString());
                      if (emailSent) _firstPress = false;
                      setState(() {
                        pressON = !pressON;
                      });
                    }
                  },
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.blue)),
                  color: Colors.white,
                )),
          if (user.verify == null || user.verify == false)
            Container(
                alignment: Alignment.bottomRight,
                height: 75.0,
                child: RawMaterialButton(
                  onPressed: () {
                    print(user);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewListing(user: user)));
                  },
                  splashColor: Colors.blue,
                  elevation: 1.0,
                  fillColor: Colors.lightBlueAccent,
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 35,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )),
          if (user.verify == true)
            Container(
                alignment: Alignment.bottomRight,
                height: 100.0,
                child: RawMaterialButton(
                  onPressed: () {
                    print(user);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewListing(user: user)));
                  },
                  splashColor: Colors.blue,
                  elevation: 1.0,
                  fillColor: Colors.lightBlueAccent,
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 35,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                )),
        ],
      ),
    );
  }
}
