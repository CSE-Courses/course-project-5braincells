import 'package:cse442_App/home%20screen/listing_widget.dart';
import 'package:cse442_App/profile%20screen/avg.dart';
import 'package:cse442_App/profile%20screen/profile_screen.dart';
import 'package:cse442_App/user%20model/user_listings_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import '../user model/user_model.dart';
import 'new_listing_page.dart';
import 'package:cse442_App/user%20model/user_model.dart';

class HomeScreen extends StatefulWidget {
  final UserModel user;
  HomeScreen({this.user});
  HomeScreenState createState() => HomeScreenState(user: user);
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

  /** Geolocator **************************************************************/
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _userPos;
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
  /**------------------------------------------------------------------------**/

  /** Checks for email verification and shows bannet & button if not **********/
  bool pressON = false;
  bool _firstPress = true;
  Widget getVerificationButton() {
    if (user.verify == null || user.verify == false) {
      return Stack(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Text(
              "Your email has not been verified",
              style: TextStyle(color: Colors.red),
            ),
          ),

          // Email button to send email verification link
          Container(
              child: RaisedButton(
            textColor: Colors.white,
            child: pressON
                ? Text("Verification email has been sent.")
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
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.blue,
          )),
        ],
      );
    } else {
      return Container();
    }
  }
  /**------------------------------------------------------------------------**/

  /** Dropdown button language options ****************************************/
  String dropdownValue = 'English';
  final dropdownLanguages = [
    'English',
    'Spanish',
    'Arabic',
    'Armenian',
    'Bengali',
    'Cantonese',
    'Creole',
    'Croatian',
    'French',
    'German',
    'Greek',
    'Gujarati',
    'Hebrew',
    'Hindi',
    'Italian',
    'Japanese',
    'Korean',
    'Mandarin',
    'Persian',
    'Polish',
    'Portuguese',
    'Punjabi',
    'Russian',
    'Serbian',
    'Tagalog',
    'Tai–Kadai',
    'Tamil',
    'Telugu',
    'Urdu',
    'Vietnamese',
    'Yiddish',
    'Pig Latin'
  ].map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
  /**------------------------------------------------------------------------**/

  /** Get listing data from server ********************************************/
  bool services = true;
  bool history = false;
  List<UserListingsModel> serviceHistory = new List();
  List<UserListingsModel> requestHistory = new List();
  List<UserListingsModel> initList;
  List<UserListingsModel> searchList;
  List<String> bookMarkedList = [];
  List<String> bookmarkedListingslist = [];

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncGet();
    });
  }

  void asyncGet() async {
    UserModel newUser = await newUserInstance(user.id);
    bookMarkedList = newUser.bookmarks;
    final List<UserListingsModel> list = await getListing();
    for (var listing in bookMarkedList) {
      await getBookmark(listing);
    }
    setState(() {
      initList = list;
      print(initList.length);
    });
  }

  //returns listing id from bookmark id
  Future<String> getBookmark(String bookmarkID) async {
    final String apiUrl =
        "https://job-5cells.herokuapp.com/listidFromBook/" + bookmarkID;
    final response = await http.get(apiUrl);
    final String temp = response.body;
    setState(() {
      bookmarkedListingslist.add(temp);
    });
  }

  Future<String> addBookmarkListing(String userId, String listingId) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/addBookMark";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": userId,
          "listing_id": listingId,
        }));
    final String temp = response.body;
    print(temp);
    return temp;
  }

  void removeBookmarkListing(String bookmarkId, String userId) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/bookmarks/delete";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "bookmark_id": bookmarkId,
          "user_id": userId,
        }));
    final String temp = response.body;
    print(temp);
  }

  Future<UserModel> newUserInstance(String userId) async {
    print("Create User is called");

    final String apiUrl = "https://job-5cells.herokuapp.com/getById/" + userId;
    final response = await http.get(apiUrl);
    print(response.body);
    if (response.statusCode == 200) {
      final String resString = response.body;
      return userModelFromJson(resString);
    } else {
      return null;
    }
  }

  // Gets listings from server and returns list of items to be displayed
  Future<List<UserListingsModel>> getListing() async {
    print("Getting listings");
    if (history) {
      if (services) {
        return serviceHistory;
      } else {
        return requestHistory;
      }
    } else {
      String apiUrl = '';
      if (services) {
        apiUrl = "https://job-5cells.herokuapp.com/allListings";
      } else {
        apiUrl = "https://job-5cells.herokuapp.com/allRequest";
      }
      final response = await http.get(apiUrl);

      final String temp = response.body;
      List<UserListingsModel> original = userListingsModelFromJson(temp);
      List<UserListingsModel> reversed = new List();
      for (UserListingsModel listing in original.reversed) {
        reversed.add(listing);
      }
      return reversed;
    }
  }

  // Search function
  Future<List<UserListingsModel>> search(String text) async {
    history = false;
    setState(() {});
    List<UserListingsModel> searchedListings = [];
    await Future.delayed(Duration(seconds: 3));
    print(dropdownValue.toLowerCase());
    for (int i = 0; i < initList.length; i++) {
      print(initList[i].language.toLowerCase());
      if (initList[i].language.toLowerCase() == dropdownValue.toLowerCase()) {
        if (initList[i]
            .jobType
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchedListings.add(initList[i]);
        } else if (initList[i]
            .description
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchedListings.add(initList[i]);
        } else if (initList[i]
            .owner
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchedListings.add(initList[i]);
        } else if (initList[i]
            .language
            .toString()
            .toLowerCase()
            .contains(text.toLowerCase())) {
          searchedListings.add(initList[i]);
        }
      }
    }
    return searchedListings;
  }
  /**------------------------------------------------------------------------**/

  /** GUI Layout **************************************************************/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          // Email Verification Banner
          getVerificationButton(),
          Flexible(
            // Search bar
            child: SearchBar<UserListingsModel>(
              crossAxisCount: 1,
              icon: Icon(
                Icons.search,
              ),
              searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
              mainAxisSpacing: 0,
              hintText: "Search",
              iconActiveColor: Colors.blue,
              cancellationWidget: Text('Cancel'),
              header: Container(
                  // Buttons under search bar
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Colors.grey[300]))),
                  //width: double.infinity,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      // Language Dropdown Button
                      Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: Colors.blue,
                          underline: SizedBox(),
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconEnabledColor: Colors.white,
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: dropdownLanguages,
                        ),
                      ),

                      // Services/Requests Button
                      ButtonTheme(
                        minWidth: 100,
                        height: 40,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            services ? "Services" : "Requests",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () async {
                            services = !services;
                            initList = await getListing();
                            setState(() {});
                          },
                        ),
                      ),

                      // History Button
                      ButtonTheme(
                        minWidth: 100,
                        height: 40,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.blue)),
                        child: RaisedButton(
                          color: history ? Colors.white : Colors.blue,
                          child: Text(
                            "History",
                            style: TextStyle(
                              color: history ? Colors.blue : Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          onPressed: () async {
                            history = !history;
                            initList = await getListing();
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  )),
              onError: (error) {
                return Center(
                  child: Text("Error occurred : $error"),
                );
              },
              emptyWidget: Center(child: Text("No results found")),
              loader: Center(
                child: Text(
                  "loading...",
                  style: TextStyle(fontSize: 20),
                ),
              ),

              // Creates a delayed screen for the listings to prevent null error when loading the listings
              suggestions: initList == null ? [] : initList,
              textStyle:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              onSearch: search,
              onItemFound: (UserListingsModel listing, int index) {
                bool isBookmarked = bookmarkedListingslist.contains(listing.id);
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 2, color: Colors.grey[300]))),
                  child: ListTile(
                    leading: Icon(
                      Icons.home_repair_service,
                      color: Colors.blue,
                    ),
                    title: Text(listing.jobType,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    subtitle: Text(listing.description,
                        style: TextStyle(color: Colors.black)),
                    // tileColor: Colors.blue,

                    trailing: IconButton(
                      icon: Icon(
                          isBookmarked
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: isBookmarked ? Colors.blue : null),
                      onPressed: () async {
                        if (isBookmarked) {
                          //remove bookmark
                        } else {
                          addBookmarkListing(user.id, listing.id);
                          bookmarkedListingslist.add(listing.id);
                        }
                        setState(() {});
                      },
                    ),

                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      if (services) {
                        serviceHistory.insert(0, listing);
                      } else {
                        requestHistory.insert(0, listing);
                      }

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Detail(listing: listing)));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),

      // Floating add listing button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(user);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => NewListing(user: user)));
        },
        child: Icon(Icons.post_add),
      ),
    );
  }
}
/**--------------------------------------------------------------------------**/

/** Screen When Listing Tile Is Tapped ****************************************/
class Detail extends StatefulWidget {
  @override
  final UserListingsModel listing;
  Detail({this.listing});

  State<StatefulWidget> createState() {
    return DetailState(listing: listing);
  }
}

class DetailState extends State<Detail> {
  UserListingsModel listing;
  DetailState({this.listing});

  String username = "";
  double stars = 0.0;
  String phoneNumber = "";

  UserModel user;
  bool sameUser = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncGet();
    });
  }

  Future<UserModel> newUserInstance(String userId) async {
    print("Create User is called");

    final String apiUrl = "https://job-5cells.herokuapp.com/getById/" + userId;
    final response = await http.get(apiUrl);
    print(response.body);
    if (response.statusCode == 200) {
      final String resString = response.body;
      return userModelFromJson(resString);
    } else {
      return null;
    }
  }

  void asyncGet() async {
    UserModel user = await newUserInstance(listing.owner);
    setState(() {
      //user = newUser;
      username = user.firstname;
      phoneNumber = user.phone;
    });
  }

  Future updateUsername(String owner) async {
    String toGet = "https://job-5cells.herokuapp.com/getById/" + owner;
    var data = await http.get(toGet);
    //String username = "";

    if (!data.body.contains("null")) {
      user = userModelFromJson(data.body);
      print(user.firstname);
      username = user.firstname;
    }
    setState(() {
      username = user.firstname;
    });
  }

  Future updateDescription(BuildContext context, String owner) async {
    String toGet = "https://job-5cells.herokuapp.com/getById/" + owner;
    var data = await http.get(toGet);
    UserModel user;
    if (!data.body.contains("null")) {
      user = userModelFromJson(data.body);
      print(user.firstname);
      username = user.firstname;
    }
    //double stars = 0.0;
    String ratingURL = "https://job-5cells.herokuapp.com/getAvgStars/" + owner;
    var ratingData = await http.get(ratingURL);
    if (!ratingData.body.contains("null")) {
      Avg avg = avgFromJson(ratingData.body);
      if (avg != null) {
        stars = avg.avg;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // updateUsername(listing.owner);
    // print(username);
    updateDescription(context, listing.owner);
    return Scaffold(
      appBar: AppBar(
        title: Text("Service App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            //Listing Title
            Center(
              child: Container(
                child: Text(
                  "Job: " + listing.jobType,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                width: 350,
                decoration: new BoxDecoration(
                  //color: Colors.lightBlue,
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  // gradient: new LinearGradient(
                  //     colors: [Colors.lightBlue, Colors.blueAccent],
                  //     begin: Alignment.centerRight,
                  //     end: Alignment.centerLeft),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
            ),
            // Listing Description
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Container(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Description: " + listing.description + "\n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "Preferred Language: " + listing.language + "\n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      //children:[] ,
                      text: "By: " + username + "\n\n",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                      // Clickable link that will allow users to view new profiles

                      // recognizer: TapGestureRecognizer()
                      //   ..onTap = () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ProfileScreen(
                      //                 user: user,
                      //                 sameUser: sameUser,
                      //               )),
                      //     );
                      //   }
                    ),
                    TextSpan(
                      text: "Rating: " +
                          stars.toString().substring(0, 3) +
                          "\n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "Date Created: " +
                          listing.createdAt.toString().substring(0, 10) +
                          "\n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                    TextSpan(
                      text: "Contact Info: " + phoneNumber.toString() + "\n\n",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ]),
                ),
                // Text(
                //   "Description: " +
                //       listing.description +
                //       "\n\n" +
                //       "Preferred Language: " +
                //       listing.language +
                //       "\n\n" +
                //       "By: " +
                //       username +
                //       "\n\n" +
                //       "Rating: " +
                //       stars.toString().substring(0, 3) +
                //       "\n\n" +
                //       "Date Created: " +
                //       listing.createdAt.toString().substring(0, 10) +
                //       "\n\n" +
                //       "Contact Info: " +
                //       phoneNumber.toString(),
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontWeight: FontWeight.normal),
                // ),
                width: 350,
                decoration: new BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  // gradient: new LinearGradient(
                  //     colors: [Colors.lightBlue, Colors.blueAccent],
                  //     begin: Alignment.centerRight,
                  //     end: Alignment.centerLeft),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/**--------------------------------------------------------------------------**/
