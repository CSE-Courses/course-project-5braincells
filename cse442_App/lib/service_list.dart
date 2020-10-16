import 'package:flutter/material.dart';

class ServiceList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceListState();
  }
}

class ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List of Services"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Text("Test of Service"),
        ],
      ),
    );
  }
}
