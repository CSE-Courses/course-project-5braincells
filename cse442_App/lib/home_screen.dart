import 'package:flutter/material.dart';
import 'service_list.dart';
import 'request_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

/*
  Home Screen Widget to be used when in the "Home" tab of the Navigation bar.
  This widget will contain the Search Bar used to find listings within the app.
*/
class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: <Widget>[
      // Search Bar
      TextField(
        // use "onSubmitted" for performing action when "enter" is clicked
        style: TextStyle(color: Colors.blue),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0))),
            prefixIcon: Icon(Icons.search),
            hintText:
                "Search here (Jobs, Services, Requests, Locations, etc.)"),
      ),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonMinWidth: 100.0,
        buttonHeight: 100.0,
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text("Tutoring"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Transport"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Services"),
            onPressed: () => "CLICK",
          ),
        ],
      ),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonMinWidth: 100.0,
        buttonHeight: 100.0,
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 4"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 5"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 6"),
            onPressed: () => "CLICK",
          ),
        ],
      ),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        buttonMinWidth: 100.0,
        buttonHeight: 100.0,
        children: <Widget>[
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 7"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 8"),
            onPressed: () => "CLICK",
          ),
          RaisedButton(
            color: Colors.blue,
            child: Text("Ex. 9"),
            onPressed: () => "CLICK",
          ),
        ],
      ),
      Container(
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              color: Colors.lightBlueAccent,
              child: Text("Services"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ServiceList()));
              },
            ),
            RaisedButton(
              color: Colors.lightBlueAccent,
              child: Text("Requests"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RequestList()));
              },
            ),
          ],
        ),
      ),
    ]));
  }
}
