import 'package:cse442_App/user%20model/user_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../user model/user_listings_model.dart';
import '../user model/user_model.dart';
import '../user model/singleListing_model.dart';
import 'package:cse442_App/home screen/home_screen.dart';
import 'package:cse442_App/user model/user_listings_model.dart';
import 'dart:convert';

class BookmarkScreen extends StatefulWidget {
  @override
  final UserModel user;

  BookmarkScreen({this.user});
  
  State<StatefulWidget> createState() {
    return BookmarkScreenState(user: user);
  }
}

class BookmarkScreenState extends State<BookmarkScreen> {
  UserModel user;
  UserListingsModel difListing;
  BookmarkScreenState({this.user});

  List<String> bookmarkList = [];
  List<String> tempList = [];
  List<String> finalList = [];
  List<SingleListing> finaltemplist = [];

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
    UserModel newUser = await newUserInstance(user.id);
    bookmarkList = newUser.bookmarks;
    for (var listing in bookmarkList) {
      await getBookmark(listing);
    }
    final List<SingleListing> randomtemporaryholder =
        singleListingFromJson(finalList.toString());
    setState(() {
      bookmarkList = newUser.bookmarks;
      finaltemplist = randomtemporaryholder;
    });
  }

  Future getBookmark(String bookmarkID) async {
    final String apiUrl =
        "https://job-5cells.herokuapp.com/listidFromBook/" + bookmarkID;
    final response = await http.get(apiUrl);
    final String temp = response.body;
    await getListingByBookmark(temp);
  }

  Future getListingByBookmark(String listingID) async {
    final String apiUrl =
        "https://job-5cells.herokuapp.com/listingFromBooks/" + listingID;
    final response = await http.get(apiUrl);
    final String temp = response.body;
    tempList.add(temp);
    setState(() {
      finalList = tempList;
    });
  }

  Future deleteBook(String userid, String bid, String lid, int index) async {
    final String apiUrl = "https://job-5cells.herokuapp.com/bookmarks/delete";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "user_id": userid,
          "bookmark_id": bid,
        }));

    if (response.statusCode == 200) {
      setState(() {
        finaltemplist.removeAt(index);
      });
    }
  }

  Widget getInformationBox(String jobType, String description, String owner,
      String bId, String lid, int index) {
    return Container(
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(width: 2, color: Colors.grey[300]))),
        child: ListTile(
          leading: Icon(Icons.home_repair_service),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.blue,
            onPressed: () async {
              await deleteBook(user.id, bId, lid, index);
            },
          ),
          title: Text(jobType,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
          subtitle: Text(description, style: TextStyle(color: Colors.black)),

          contentPadding: EdgeInsets.all(10),
          selected: true,
          shape: RoundedRectangleBorder(),
          //selectedTileColor: Colors.lightBlue[500],
          onTap: () {
            // if (finaltemplist != null) {
            //   for (var listing in finaltemplist) {
            difListing.jobType = jobType;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Detail(
                      listing: difListing,
                    )));
          },
        )); //here
  }

  var testList = [
    "Potato Farmer",
    "I farm potatoes for you",
    "Tutor",
    "I tutor for you"
  ];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        
          child: ListView.builder(
            
              itemCount: finaltemplist.length,
              itemBuilder: (BuildContext context, int index) {
                return getInformationBox(
                    finaltemplist[index].jobType,
                    finaltemplist[index].description,
                    finaltemplist[index].owner,
                    bookmarkList[index],
                    finaltemplist[index].id,
                    index);
              })),
    );
  }
}
