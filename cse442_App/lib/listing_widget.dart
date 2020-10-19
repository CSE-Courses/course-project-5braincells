import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'reviews.dart';
import 'dart:convert';
import 'user_list_list_model.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

// ignore: camel_case_types
class Listing_widget extends StatefulWidget {
  final UserModel user;
  Listing_widget({this.user});

  State<StatefulWidget> createState() {
    print(user);
    return Listing_widgetState(user: user);
  }
}

// ignore: camel_case_types
class Listing_widgetState extends State<Listing_widget> {
  final UserModel user;
  Listing_widgetState({this.user});

  List<List<UserList>> initList = [];
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
    });
  }

  // static const String url =
  //     "https://job-5cells.herokuapp.com/getRatingById/5f88cfd834b4e3000458fd6c";

  Future<List<List<UserList>>> getListings() async {
    String toGet =
        "https://job-5cells.herokuapp.com/getListingsById/" + user.id;
    var data = await http.get(toGet);
    List<List<UserList>> reviews = userListFromJson(data.body);

    return reviews;
  }

  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       final List<Review> reviews =
  //           reviewsFromJson(response.body).cast<Review>();
  //       print(reviews);
  //       return reviews;
  //     } else {
  //       return List<Review>();
  //     }
  //   } catch (e) {
  //     return List<Review>();
  //   }
  // }

  // void initState() {
  //   super.initState();
  //   _loading = true;
  //   review_services.getComments().then((reviews) {
  //     setState(() {
  //       _reviews = reviews;
  //       _loading = false;
  //     });
  //   });
  // }

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

              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading....")));
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
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}