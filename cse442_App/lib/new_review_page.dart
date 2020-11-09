import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rating_bar/rating_bar.dart';
import 'user_model.dart';

class NewReview extends StatefulWidget {
  final UserModel user;
  NewReview({this.user});

  @override
  State<StatefulWidget> createState() {
    print(user);
    // TODO: implement createState
    return NewReviewState(user: user);
  }
}

Future<String> addReview(double rating, String review, String id) async {

  return null;
}

class NewReviewState extends State<NewReview>{
  final UserModel user;
  NewReviewState({this.user});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController reviewController = TextEditingController();
  bool added = false;

  Widget addReviewButton(){
    return Container(
      child: ButtonTheme(
        minWidth: double.infinity,
        height: 50,
        child: RaisedButton(
          elevation: 5,
          color: Colors.white,
          child: Text(
            "Add Review",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontFamily: 'OpenSans'
            ),
          ),
          onPressed: () async {
            // Do some behind the scenes shenanigans to add the review to database
            print("Added Review");
            setState(() {
              added = true;
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Review"),
      ),
      body: Stack(
        children: [
          Builder(
            builder: (context) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Column(
                      children: [
                        RatingBar(
                          size: 50,
                          initialRating: 1,
                          filledIcon: Icons.star,
                          emptyIcon: Icons.star_border,
                          isHalfAllowed: false,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(Icons.rate_review),
                            hintText: "Leave a review",
                            labelText: "Review",
                          ),
                          controller: reviewController,
                          maxLength: 200,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          validator: (value) {
                            if (value.isEmpty){
                              return "Please write a review";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: addReviewButton(),
            ),
          )
        ],
      )
    );
  }
}