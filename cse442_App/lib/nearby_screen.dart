import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'user_model.dart';

class NearbyScreen extends StatefulWidget {
  final UserModel user;
  NearbyScreen({this.user});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NearbyScreenState(user: user);
  }
}

/*
  Home Screen Widget to be used when in the "Home" tab of the Navigation bar.
  This widget will contain the Search Bar used to find listings within the app.
*/
class NearbyScreenState extends State<NearbyScreen> {
  final UserModel user;
  NearbyScreenState({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Text("TEST")],
      ),
    );
  }
}
