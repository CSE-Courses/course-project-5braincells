import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}

class FlapSearchBar extends StatefulWidget {
  @override
  _FlapSearchBarState createState() => _FlapSearchBarState();
}

class _FlapSearchBarState extends State<FlapSearchBar> {
  final SearchBarController<Post> _searchBarController = SearchBarController();

  Future<List<Post>> search(String text) async {
    await Future.delayed(Duration(seconds: 2));
    return List.generate(text.length, (int index) {
      return Post(
        "Title : $text $index",
        "Body : $text $index",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(10, 15, 10, 10)),
          Flexible(
            child: SearchBar<Post>(
              crossAxisCount: 2,
              indexedScaledTileBuilder: (int index) => ScaledTile.count(1, .8),
              icon: Icon(
                Icons.search,
                color: Colors.blue,
              ),
              searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
              headerPadding: EdgeInsets.symmetric(horizontal: 10),
              listPadding: EdgeInsets.symmetric(horizontal: 10),
              mainAxisSpacing: 20,
              crossAxisSpacing: 15,
              hintText: "Search Bar",
              iconActiveColor: Colors.red,
              placeHolder: Center(
                child: Text(
                  "Search for Listings",
                  style: TextStyle(fontSize: 18),
                ),
              ),
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
              textStyle:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              onSearch: search,
              onItemFound: (Post post, int index) {
                return ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                  tileColor: Colors.blue,
                );
              },
            ),
          ),
          Align(
            alignment: Alignment(-.9, 1),
            child: RaisedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Icon(Icons.arrow_back_sharp),
                  Text("Back"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Detail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("Detail"),
          ],
        ),
      ),
    );
  }
}
