import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _ub = CameraPosition(
    target: LatLng(43.000067, -78.789187),
    zoom: 15,
  );

  static final CameraPosition _ubFlint = CameraPosition(
    bearing: 0,
    target: LatLng(43.000067, -78.789187),
    tilt: 0,
    zoom: 18,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
          ),
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _ub,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment(-.8, .92),
        child: FloatingActionButton.extended(
          onPressed: _goToFlint,
          label: Text('To Flint Loop!'),
          icon: Icon(Icons.location_on),
        ),
      ),
    );
  }

  Future<void> _goToFlint() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_ubFlint));
  }
}
