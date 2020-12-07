import 'package:cse442_App/profile%20screen/new_review_page.dart';

import 'reviews.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../user model/user_model.dart';
import 'review_widget.dart';
import '../home screen/listing_widget.dart';
import '../edit_widget.dart';
import 'avg.dart';
import 'dart:core';
import 'dart:io';
import 'image_capture.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'profile_screen.dart';
import 'package:imgur/imgur.dart' as imgur;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Uploader extends StatefulWidget {
  final File file;
  final UserModel user;
  Uploader({this.file, this.user});

  State<StatefulWidget> createState() {
    return _UploaderState(file: file, user: user);
  }
}

class _UploaderState extends State<Uploader> {
  final File file;
  UserModel user;
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://cells-5f4e7.appspot.com');
  StorageUploadTask _utask;

  _UploaderState({this.file, this.user});

  Future<String> testUpload() async {
    // open a bytestream
    String filePath = 'images/${DateTime.now()}.png';
    setState(() {
      _utask = _storage.ref().child(filePath).putFile(widget.file);
    });
    var dowurl = await (await _utask.onComplete).ref.getDownloadURL();
    String url = dowurl.toString();

    return url;
    // var stream = new http.ByteStream(imageFile.openRead());
    // stream.cast();
    // // get file length
    // var length = await imageFile.length();
    // print(length);
    // // string to uri
    // var uri = Uri.parse("https://api.imgur.com/3/image/");

    // // create multipart request
    // var request = new http.MultipartRequest("POST", uri);

    // // multipart that takes file
    // // var multipartFile = new http.MultipartFile('file', stream, length,
    // //     filename: basename(imageFile.path));
    // var path = Uri.parse(imageFile.path);
    // request.files.add(new http.MultipartFile.fromBytes(
    //     'file', await File.fromUri(path).readAsBytes(),
    //     contentType: new MediaType('image', 'jpeg')));
    // Map<String, String> headers = {
    //   "Authorization": "Client-ID e3441af7eaad282"
    // };

    // request.headers.addAll(headers);

    // // add file to multipart
    // // request.files.add(multipartFile);
    // print(imageFile);

    // // send
    // var response = await request.send();
    // print(response.statusCode);

    // // listen for response
    // response.stream.transform(utf8.decoder).listen((value) {
    //   print("Working");
    //   print(value);
    // });
  }

  @override
  Widget build(BuildContext context) {
    if (_utask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _utask.events,
        builder: (context, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Column(
            children: [
              if (_utask.isComplete) Text("Uploaded Successfully"),
              if (_utask.isPaused)
                FlatButton(
                    onPressed: _utask.resume, child: Icon(Icons.play_arrow)),
              if (_utask.isInProgress)
                FlatButton(onPressed: _utask.pause, child: Icon(Icons.pause)),
              LinearProgressIndicator(value: progressPercent),
              Text('${(progressPercent * 100).toStringAsFixed(2)}%'),
              RaisedButton(
                  child: Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'san-serif',
                      color: Colors.lightBlue,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(user: user, sameUser: true)));
                  }),
            ],
          );
        },
      );
    } else {
      return FlatButton.icon(
        label: Text('Upload Image'),
        icon: Icon(Icons.cloud_upload),
        onPressed: () async {
          String x = await testUpload();
          print(x);
          final String apiUrl = "https://job-5cells.herokuapp.com/update/img";
          final response = await http.post(apiUrl,
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: json.encode({
                "imgSrc": x,
                "user_id": this.user.id,
              }));
          print(response.body);
          if (response.statusCode == 200) {
            final String resString = response.body;
            UserModel newUser = userModelFromJson(resString);

            setState(() {
              user = newUser;
            });
          }
        },
      );
    }

    //   return RaisedButton(
    //     color: Colors.lightBlueAccent,
    //     child: Text(
    //       "Confirm Image",
    //       style: TextStyle(fontSize: 20, color: Colors.white),
    //     ),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15),
    //         side: BorderSide(color: Colors.lightBlue, width: 2.0)),
    //     onPressed: () {
    //       testUpload(this.file);
    //     },
    //   );
    // }
  }
}
