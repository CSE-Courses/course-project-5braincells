import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'userListings_model.dart';

class ServiceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceListState();
  }
}

String test = "";
Future<List<UserListingsModel>> getListing() async {
    print("Getting listings");
    
    final String apiUrl = "https://job-5cells.herokuapp.com/allListings";
    final response = await http.get(apiUrl);

      final String temp = response.body;
      return userListingsModelFromJson(temp);
}

Widget testText() {
  return Container(
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          final List<UserListingsModel> testingUserList = await getListing();
          print(testingUserList[0].jobType);
        },
        padding: EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blue)
        ),
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
      )
  );
}

class ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Services"),
        centerTitle: true,
      ),
      body:Stack(
        children: <Widget> [
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 80.0,
            ),
            child: Column(
              children: <Widget>[
              SizedBox(height: 30.0),
              testText(),
              ]
            ),
          ),
         )
        ]
      )
    );
  }
}
