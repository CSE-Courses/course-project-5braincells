import 'dart:math';
import 'dart:ui';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import '../user model/user_list_model.dart';
import '../user model/user_listings_model.dart';
import '../user model/user_model.dart';

// class Post {
//   final String title;
//   final String body;

//   Post(this.title, this.body);
// }

class FlapSearchBar extends StatefulWidget {
  @override
  final UserModel user;
  FlapSearchBar({this.user});
  _FlapSearchBarState createState() => _FlapSearchBarState(user: user);
}

class _FlapSearchBarState extends State<FlapSearchBar> {
  // final SearchBarController<Post> _searchBarController = SearchBarController();
  final UserModel user;
  _FlapSearchBarState({this.user});

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
    'Pig Latin']
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
  }).toList();
  bool services = true;

  List<UserListingsModel> initList;
  List<UserListingsModel> searchList;
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncGet();
    });
  }

  void asyncGet() async {
    final List<UserListingsModel> list = await getListing();
    setState(() {
      initList = list;
      print(initList.length);
    });
  }

  // static const String url =
  //     "https://job-5cells.herokuapp.com/getRatingById/5f88cfd834b4e3000458fd6c";

  Future<List<UserListingsModel>> getListing() async {
    print("Getting listings");

    String apiUrl = '';
    if (services){
      apiUrl = "https://job-5cells.herokuapp.com/allListings";
    } else {
      apiUrl = "https://job-5cells.herokuapp.com/allRequest";
    }
    final response = await http.get(apiUrl);

    final String temp = response.body;
    return userListingsModelFromJson(temp);
  }

  Future<List<UserListingsModel>> search(String text) async {
    List<UserListingsModel> searchedListings = [];
    await Future.delayed(Duration(seconds: 3));
    print(dropdownValue.toLowerCase());
    for (int i = 0; i < initList.length; i++) {
      print(initList[i].language.toLowerCase());
      if (initList[i].language.toLowerCase() == dropdownValue.toLowerCase()){
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service App"),
        centerTitle: true,
      ),

      body: Flex(
        direction: Axis.vertical,
        children: [
          //Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10)),
          Flexible(
            child: SearchBar<UserListingsModel>(
              crossAxisCount: 1,
              //indexedScaledTileBuilder: (int index) => ScaledTile.count(1, .3),
              icon: Icon(Icons.search,),
              searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
              //headerPadding: EdgeInsets.symmetric(horizontal: 10),
              //listPadding: EdgeInsets.symmetric(horizontal: 0),
              mainAxisSpacing: 0,
              //crossAxisSpacing: 20,
              hintText: "Search",
              iconActiveColor: Colors.blue,
              cancellationWidget: Text('Cancel'),
              header: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 2, color: Colors.grey[300])
                      )
                  ),
                  //height: 80,
                  width: double.infinity,
                  //color: Colors.white,
                  child: ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: Colors.blue,
                          underline: SizedBox(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20
                          ),
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconEnabledColor: Colors.white,
                          onChanged: (String newValue) {
                            setState(() {dropdownValue = newValue;});
                          },
                          items: dropdownLanguages,
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 150,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            services ? "Services" : "Requests",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            services = !services;
                            initList = await getListing();
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  )
              ),
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
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 2, color: Colors.grey[300])
                      )
                  ),
                  child: ListTile(
                    title: Text(listing.jobType,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    subtitle: Text(listing.description,
                        style: TextStyle(color: Colors.black)),
                    // tileColor: Colors.blue,
                    leading: Icon(
                      Icons.description,
                      color: Colors.blue,
                    ),
                    trailing: Icon(
                      Icons.keyboard_arrow_right,
                      size: 30,
                      color: Colors.blue,
                    ),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Detail(
                            listing: listing,
                          )));
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Detail extends StatelessWidget {
  final UserListingsModel listing;
  Detail({this.listing});

  @override
  Widget build(BuildContext context) {
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
                  listing.jobType,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                width: 350,
                decoration: new BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(20),
                  gradient: new LinearGradient(
                      colors: [Colors.lightBlue, Colors.blueAccent],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft),
                ),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
              ),
            ),
            // Listing Description
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Container(
                  child: Text(
                    "Description: " + listing.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  width: 350,
                  decoration: new BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(3),
                    gradient: new LinearGradient(
                        colors: [Colors.lightBlue, Colors.blueAccent],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft),
                  ),
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                ),
              ),
            ),
            Text(
              listing.language,
              style: TextStyle(fontSize: 16),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(listing.createdAt.toString()),
            ),
          ],
        ),
      ),
    );
  }
}
