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
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import './uploader.dart';
import 'image_capture.dart';
import 'uploader.dart';

class ImageCapture extends StatefulWidget {
  final UserModel user;
  ImageCapture({this.user});

  State<StatefulWidget> createState() {
    return _ImageCaptureState(user: user);
  }
  // createState() => _ImageCaptureState(user: user);
}

class _ImageCaptureState extends State<ImageCapture> {
  File _imageFile;
  final UserModel user;
  _ImageCaptureState({this.user});

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  void _clear() {
    setState(() => {_imageFile = null});
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(sourcePath: _imageFile.path);
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(
            child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () => _pickImage(ImageSource.camera)),
            IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () => _pickImage(ImageSource.gallery)),
          ],
        )),
        body: ListView(children: <Widget>[
          if (_imageFile != null) ...{
            Image.file(_imageFile),
            Row(
              children: [
                FlatButton(onPressed: _cropImage, child: Icon(Icons.crop)),
                FlatButton(onPressed: _clear, child: Icon(Icons.refresh))
              ],
            ),
            Uploader(file: _imageFile)
          }
        ]));
  }
}
