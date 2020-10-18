import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'reviews.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Review_widget extends StatefulWidget {
  Review_widget() : super();
  State<StatefulWidget> createState() {
    return Review_widgetState();
  }
}

// ignore: camel_case_types
class Review_widgetState extends State<Review_widget> {
  static const String url =
      "https://job-5cells.herokuapp.com/getRatingById/5f88cfd834b4e3000458fd6c";
  static Future<List<Review>> getComments() async {
    List<Review> reviews;
    var data = await http.get(url);
    reviews = (json.decode(data.body) as List)
        .map((i) => Review.fromJson(i))
        .toList();
    print(reviews.length);
    print("helllo");
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
              //print(snapshot.data.length);

              // if (snapshot.data == null) {
              //   return Container(child: Center(child: Text("Loading....")));
              // } else {
              return ListView.builder(
                  itemCount: 6,
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
                          title: Text("Sample Comment."),
                          subtitle: RatingBar.readOnly(
                              size: 16,
                              filledIcon: Icons.star,
                              initialRating: 4.5,
                              isHalfAllowed: true,
                              halfFilledIcon: Icons.star_half,
                              emptyIcon: Icons.star_border),
                        ));
                  });
              //}
            }),
      ),
    );
  }
}
