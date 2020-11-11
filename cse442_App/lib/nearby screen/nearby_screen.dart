import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../user model/user_list_list_model.dart';
import '../user model/user_model.dart';
import 'nearby_listings.dart';

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
  GoogleMapController mapController;

  final Geolocator _geolocator = Geolocator();
  static LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Method for retrieving the current location
  void _getCurrentLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
      print('${placemark[0].name}');
    });
  }

  var initList = [];
  // Future<List<List<UserList>>> getListings() async {
  //   String toGet =
  //       "https://job-5cells.herokuapp.com/getListingsById/" + user.id;
  //   var data = await http.get(toGet);
  //   List<List<UserList>> lists = userListFromJson(data.body);
  //   setState(() {
  //     initList = lists;
  //     print(initList.length);
  //   });
  //   return lists;
  // }

  // static final CameraPosition _userLocation = CameraPosition(
  //     target: LatLng(_currentPosition.latitude, _currentPosition.longitude));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentLocation == null
          // Creates a loading screen for the map to prevent null error when getting user's location
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  ),
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition:
                        CameraPosition(target: _currentLocation, zoom: 15),
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      setState(() {
                        _controller.complete(controller);
                      });
                    },
                    onTap: (argument) =>
                        {print('CURRENT POS: $_currentLocation')},
                  ),
                ],
              ),
            ),
      floatingActionButton: Align(
        alignment: Alignment(-.8, .92),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NearbyListing()));
          },
          label: Text('Listings Near Me!'),
          icon: Icon(Icons.location_on),
        ),
      ),
    );
  }

  // Future<void> _goToFlint() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_ubFlint));
  // }

  // static final CameraPosition _ub = CameraPosition(
  //   target: LatLng(43.000067, -78.789187),
  //   zoom: 15,
  // );

  // static final CameraPosition _ubFlint = CameraPosition(
  //   bearing: 0,
  //   target: LatLng(43.000067, -78.789187),
  //   tilt: 0,
  //   zoom: 18,
  // );
}
