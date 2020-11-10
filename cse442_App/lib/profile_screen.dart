import 'package:cse442_App/new_review_page.dart';

import 'reviews.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_model.dart';
import 'review_widget.dart';
import 'listing_widget.dart';
import 'edit_widget.dart';
import 'avg.dart';
import 'dart:core';

class ProfileScreen extends StatefulWidget {
  final UserModel user;
  final bool sameUser;
  ProfileScreen({this.user, this.sameUser});
  @override
  State<StatefulWidget> createState() {
    print("profile");
    print(user.id);

    // TODO: implement createState
    return ProfileScreenState(user: user, sameUser: sameUser);
  }
}

/*
  Profile Screen Widget to be used when in the "Profile" tab of the Navigation bar.
  This widget will contain the Search Bar used to find listings within the app.
*/
class ProfileScreenState extends State<ProfileScreen> {
  final UserModel user;
  final bool sameUser;
  ProfileScreenState({this.user, this.sameUser});
  double stars = 0.0;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncGet();
    });
  }

  void asyncGet() async {
    double star = await getAvgStar();
  }

  Future<double> getAvgStar() async {
    String toGet = "https://job-5cells.herokuapp.com/getAvgStars/" + user.id;
    var data = await http.get(toGet);
    if (!data.body.contains("null")) {
      Avg avg = avgFromJson(data.body);
      print(avg);
      if (avg != null) {
        setState(() {
          stars = avg.avg;
          print(avg.avg);
        });
      }
    }

    return 0.0;
  }

  List<String> tabNames = ["Bio", "Listings", "Reviews"];

  String result = "";

  Widget bio() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
        child: Wrap(
          children: [
            Expanded(
              child: SizedBox(
                height: 300,
                child: ListView(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Hello,",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 38,
                          color: Colors.blue,
                          fontFamily: 'arial',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "My name is " +
                          user.firstname +
                          ". I live in " +
                          user.location +
                          ". You can checkout my available listings in the next tab. My preferred language is " +
                          user.language +
                          ".",
                      style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),

              // ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> getTabs(List<String> tabNames) {
    List<Widget> tabs = new List();
    for (String name in tabNames) {
      tabs.add(Container(
          child: Text(
        name,
        //textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87, fontSize: 15, fontWeight: FontWeight.bold),
      )));
    }
    return tabs;
  }

  List<Widget> getBios(List<String> bios) {
    List<Widget> bioTabs = new List();
    for (String bio in bios) {
      bioTabs.add(Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Text(
                bio,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ))
          //Padding(padding: EdgeInsets.all(10));
          );
    }
    return bioTabs;
  }

  Widget getEditButton() {
    if (sameUser) {
      return Container();
    } else {
      return FloatingActionButton(
        onPressed: () {
          print(user);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewReview(
                        user: user,
                        sameUser: sameUser,
                      )));
        },
        child: Icon(Icons.rate_review),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.blue),
        home: DefaultTabController(
          length: 3,
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            body: Container(
                child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://visme.co/blog/wp-content/uploads/2017/07/50-Beautiful-and-Minimalist-Presentation-Backgrounds-04.jpg"),
                              fit: BoxFit.cover)),
                    ),
                    // Padding(
                    //     padding: EdgeInsets.fromLTRB(240, 60, 0, 0),
                    //     child: IconButton(
                    //       icon: Icon(Icons.camera_alt),
                    //       onPressed: () {},
                    //     )),
                    Container(
                      margin: EdgeInsets.only(top: 50, left: 135),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://external-preview.redd.it/9AWn6JJOzBSl3XLfNHCtEtfjaw3iUPriDltGV10P5A4.jpg?auto=webp&s=19b8fe70cd041d6fc3e49fbee361c9b0c46c049f"),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 30,
                              spreadRadius: 3,
                              offset: Offset(10, 10),
                            )
                          ]),
                    )
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(
                          user.firstname,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          user.location,
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text("Rating:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                        RatingBar.readOnly(
                            size: 30,
                            filledIcon: Icons.star,
                            initialRating: stars,
                            isHalfAllowed: true,
                            halfFilledIcon: Icons.star_half,
                            emptyIcon: Icons.star_border),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: new AppBar(
                    title: TabBar(
                      tabs: getTabs(tabNames),
                      //isScrollable: true,
                      indicator: UnderlineTabIndicator(
                        insets: EdgeInsets.all(0.1),
                      ),
                    ),
                    backgroundColor: Colors.lightBlue[200],
                  ),
                ),
                Expanded(
                    child: TabBarView(children: <Widget>[
                  bio(),
                  Listing_widget(user: user, sameUser: sameUser),
                  Review_widget(user: user, sameUser: sameUser)
                ]))
              ],
            )),
            floatingActionButton: getEditButton(),
          ),
        ));
  }
}
