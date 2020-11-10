import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'avg.dart';
import 'user_model.dart';
import 'user_list_list_model.dart';
import 'service_list.dart';
import 'userListings_model.dart';
import 'profile_screen.dart';

class NearbyListing extends StatefulWidget {
  final UserModel user;
  NearbyListing({this.user});

  State<StatefulWidget> createState() {
    print(user);
    return NearbyListingState(user: user);
  }
}

class NearbyListingState extends State<NearbyListing> {
  final UserModel user;
  NearbyListingState({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Listings Near Me"),
      ),
      body: RaisedButton(
        onPressed: () {},
        child: Text("TEMPORARY HOLDER"),
      ),
    );
  }
}
