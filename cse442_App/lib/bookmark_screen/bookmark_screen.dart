import 'package:flutter/material.dart';

import '../user model/user_model.dart';

class BookmarkScreen extends StatefulWidget {
  final UserModel user;
  BookmarkScreen({this.user});
  @override
  State<StatefulWidget> createState() {
    return BookmarkScreenState();
  }
}

class BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 20.0),
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(
                "Bookmarked Listings",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Roboto"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,

                //Add bookmarked listings here
              )
            ]),
      ),
    );
  }
}
