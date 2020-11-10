import 'dart:math';
import 'dart:ui';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'user_list_list_model.dart';
import 'userListings_model.dart';
import 'user_model.dart';

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

    final String apiUrl = "https://job-5cells.herokuapp.com/allListings";
    final response = await http.get(apiUrl);

    final String temp = response.body;
    return userListingsModelFromJson(temp);
  }

  Future<List<UserListingsModel>> search(String text) async {
    List<UserListingsModel> searchedListings = [];
    await Future.delayed(Duration(seconds: 2));
    for (int i = 0; i < initList.length; i++) {
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
          Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 10)),
          Flexible(
            child: SearchBar<UserListingsModel>(
              crossAxisCount: 1,
              indexedScaledTileBuilder: (int index) => ScaledTile.count(1, .3),
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
              headerPadding: EdgeInsets.symmetric(horizontal: 10),
              listPadding: EdgeInsets.symmetric(horizontal: 10),
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              hintText: "Search",
              iconActiveColor: Colors.red,
              // placeHolder: Center(
              //   child: Text(
              //     "Search for Listings",
              //     style: TextStyle(fontSize: 18),
              //   ),
              // ),
              onError: (error) {
                return Center(
                  child: Text("Error occurred : $error"),
                );
              },
              emptyWidget: Text("No results found"),
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
                return ListTile(
                  title: Text(listing.jobType,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  subtitle: Text(listing.description,
                      style: TextStyle(color: Colors.white)),
                  // tileColor: Colors.blue,
                  leading: Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    size: 30,
                    color: Colors.white,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  selected: true,
                  shape: RoundedRectangleBorder(),
                  selectedTileColor: Colors.lightBlue[500],
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Detail(
                              listing: listing,
                            )));
                  },
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
            // Listing Title
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
