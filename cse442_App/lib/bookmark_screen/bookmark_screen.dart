import 'package:cse442_App/user%20model/user_list_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../user model/user_listings_model.dart';
import '../user model/user_model.dart';
import '../user model/singleListing_model.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  final UserModel user;
  BookmarkScreen({this.user});
  State<StatefulWidget> createState() {
    return BookmarkScreenState(user: user);
  }
}

class BookmarkScreenState extends State<BookmarkScreen> {
  final UserModel user;
  BookmarkScreenState({this.user});

  List<String> bookmarkList = [];
  List<String> tempList = [];
  List<String> finalList = [];
  List<SingleListing> finaltemplist;

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
      finaltemplist = randomtemporaryholder;
      print(finaltemplist.length);
    });
  }

  void getBookmark(String bookmarkID) async {
    final String apiUrl =
        "https://job-5cells.herokuapp.com/listidFromBook/" + bookmarkID;
    final response = await http.get(apiUrl);
    final String temp = response.body;
    await getListingByBookmark(temp);
  }

  void getListingByBookmark(String listingID) async {
    final String apiUrl =
        "https://job-5cells.herokuapp.com/listingFromBooks/" + listingID;
    final response = await http.get(apiUrl);
    final String temp = response.body;
    tempList.add(temp);
    setState(() {
      finalList = tempList;
    });
  }

  Widget getInformationBox(
    String jobType,
    String description,
    String owner,
  ) {
    return ListTile(
      title: Text(jobType,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      subtitle: Text(description, style: TextStyle(color: Colors.white)),
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
      // onTap: () {
      //   Navigator.of(context).push(MaterialPageRoute(
      //       builder: (context) => Detail(
      //             listing: listing,
      //           )));
      // },
    );
  }

  var testList = [
    "Potato Farmer",
    "I farm potatoes for you",
    "Tutor",
    "I tutor for you"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Center(
            child: Text(
              "Bookmarked Listings",
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Roboto"),
            ),
          ),
          //this should be in listview or something, gives a error if there is too much listings to the bottom of the screen
          if (finaltemplist != null)
            for (var listing in finaltemplist)
              getInformationBox(
                  listing.jobType, listing.description, listing.owner),
        ],
      ),
    );
  }
}
