import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RequestListState();
  }
}

class RequestListState extends State<RequestList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Requests"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Text("Test of Request"),
        ],
      ),
    );
  }
}
