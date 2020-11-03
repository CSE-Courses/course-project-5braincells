import 'package:cse442_App/user_model.dart';
import 'package:flutter/material.dart';
import 'service_list.dart';
import 'request_list.dart';
import 'user_model.dart';
import 'new_listing_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  HomeScreen({this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState(user: user);
  }
}

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
  Widget build(BuildContext context) {
    print(user);
    print(user.verify);
    return Scaffold(
        body: ListView(children: <Widget>[
      // Search Bar
      TextField(
        // use "onSubmitted" for performing action when "enter" is clicked
        style: TextStyle(color: Colors.blue),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            prefixIcon: Icon(Icons.search),
            hintText:
                "Search here (Jobs, Services, Requests, Locations, etc.)"),
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ServiceList()));
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RequestList()));
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
            child: Text("Services"),
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
            child: Text("Ex. 4"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 5"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 6"),
            onPressed: () => "CLICK",
          ),
        ],
      ),
      // Add Listing Button
      if (user.verify == null || user.verify == false)
        Container(
          alignment: Alignment.center,
          child: Text(
            "Your email has not been verified",
            style: TextStyle(color: Colors.red),
          ),
        ),

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
              shape:
                  RoundedRectangleBorder(side: BorderSide(color: Colors.blue)),
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
            height: 140.0,
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
      // ButtonBar(
      //   alignment: MainAxisAlignment.center,
      //   buttonMinWidth: 100.0,
      //   buttonHeight: 100.0,
      //   children: <Widget>[
      //     RaisedButton(
      //       color: Colors.blue,
      //       child: Text("Ex. 7"),
      //       onPressed: () => "CLICK",
      //     ),
      //     RaisedButton(
      //       color: Colors.blue,
      //       child: Text("Ex. 8"),
      //       onPressed: () => "CLICK",
      //     ),
      //     RaisedButton(
      //       color: Colors.blue,
      //       child: Text("Ex. 9"),
      //       onPressed: () => "CLICK",
      //     ),
      //   ],
      // ),
    ]));
  }
}
