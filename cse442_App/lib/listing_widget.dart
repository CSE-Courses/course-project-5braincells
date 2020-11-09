import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'user_list_list_model.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';
import 'dart:convert';

// ignore: camel_case_types
class Listing_widget extends StatefulWidget {
  final UserModel user;
  final bool sameUser;
  Listing_widget({this.user, this.sameUser});

  State<StatefulWidget> createState() {
    print(user);
    return Listing_widgetState(user: user, sameUser: sameUser);
  }
}

// ignore: camel_case_types
class Listing_widgetState extends State<Listing_widget> {
  final UserModel user;
  final bool sameUser;
  Listing_widgetState({this.user, this.sameUser});

  List<List<UserList>> initList;
  //initialize widiget
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncGet();
    });
  }

  void asyncGet() async {
    final List<List<UserList>> list = await getListings();
    setState(() {
      initList = list;
      print(initList.length);
    });
  }

  // static const String url =
  //     "https://job-5cells.herokuapp.com/getRatingById/5f88cfd834b4e3000458fd6c";

  Future<List<List<UserList>>> getListings() async {
    String toGet =
        "https://job-5cells.herokuapp.com/getListingsById/" + user.id;
    var data = await http.get(toGet);
    List<List<UserList>> lists = userListFromJson(data.body);
    setState(() {
      initList = lists;
      print(initList.length);
    });
    return lists;
  }

  void deleteListing(String uid, String listId) async {
    print(uid);
    print(listId);
    final String apiUrl = "https://job-5cells.herokuapp.com/listings/delete";
    final response = await http.post(apiUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({
          "userId": uid,
          "listingId": listId,
        }));
    print(response.body);
    if (response.statusCode == 204) {
      final List<List<UserList>> newList = await getListings();
      setState(() {
        initList = newList;
      });
    } else {
      return null;
    }
  }

  Widget getDeleteButton(id) {
    if (sameUser) {
      return IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          deleteListing(user.id, id);
        },
      );
    } else {
      return IconButton(
        icon: Icon(Icons.message),
        onPressed: () {
          // Delete the listing
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: FutureBuilder(
            future: getListings(),
            builder: (context, snapshot) {
              // Review review = reviews[index];
              // print(snapshot.data);
              // print(snapshot.data.length);

              if (snapshot.data == null || initList.length == null) {
                return Container(child: Center(child: Text("Loading....")));
              } else if (initList.length == 0) {
                return Container(
                    child: Center(
                        child: Text(
                            "No listings yet. You can add your listings on the homepage")));
              } else {
                return ListView.builder(
                    itemCount: initList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.all(12.0),
                        padding: const EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.lightBlue,
                        )),
                        height: 70,
                        child: ListTile(
                          title: Text('(' +
                              initList[index][0].language +
                              ')' +
                              initList[index][0].jobType.toString()),
                          subtitle:
                              Text(initList[index][0].description.toString()),
                          trailing: getDeleteButton(initList[index][0].id),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
