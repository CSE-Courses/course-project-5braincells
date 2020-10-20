import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'review_model.dart';
import 'package:http/http.dart' as http;
import 'user_model.dart';

// ignore: camel_case_types
class Review_widget extends StatefulWidget {
  final UserModel user;
  Review_widget({this.user});

  State<StatefulWidget> createState() {
    print(user);
    return Review_widgetState(user: user);
  }
}

/*
  Review Widget to be used to display a review in the profile page.
  This widget will contain the rating score as well as the review.
*/

// ignore: camel_case_types
class Review_widgetState extends State<Review_widget> {
  final UserModel user;
  Review_widgetState({this.user});

  List<List<Review>> initReview = [];
  //initialize widget
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      asyncGet();
    });
  }

  void asyncGet() async {
    final List<List<Review>> review = await getComments();
    setState(() {
      initReview = review;
    });
  }

  // static const String url =
  //     "https://job-5cells.herokuapp.com/getRatingById/5f88cfd834b4e3000458fd6c";

  Future<List<List<Review>>> getComments() async {
    String toGet = "https://job-5cells.herokuapp.com/getRatingById/" + user.id;
    var data = await http.get(toGet);
    List<List<Review>> reviews = reviewsFromJson(data.body);

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
            future: getComments(),
            builder: (context, snapshot) {
              // Review review = reviews[index];
              // print(snapshot.data);
              // print(snapshot.data.length);

              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading....")));
              } else {
                return ListView.builder(
                    itemCount: initReview.length,
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
                          title: Text(initReview[index][0].comment),
                          subtitle: RatingBar.readOnly(
                              size: 16,
                              filledIcon: Icons.star,
                              initialRating: double.parse(initReview[index][0].stars),
                              isHalfAllowed: true,
                              halfFilledIcon: Icons.star_half,
                              emptyIcon: Icons.star_border),
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
