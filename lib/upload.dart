import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  var result;
  upload(File imageFile) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https://covidapi-alexuni.herokuapp.com/API");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('img', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      result = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
        body: Container(
            child: ListView(
          children: [
            SizedBox(height: 50),
            Row(children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "    Cancer",
                        style: TextStyle(
                            fontFamily: 'Zen Dots',
                            fontSize: 20,
                            color: Colors.teal),
                      ),
                    ),
                    Expanded(child: Image.asset("images/logo.png")),
                    Expanded(
                      child: Text(
                        "    Free",
                        style: TextStyle(
                            fontFamily: 'Zen Dots',
                            fontSize: 20,
                            color: Colors.teal),
                      ),
                    )
                  ],
                ),
              )
            ]),
            Row(children: <Widget>[
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          width: 250,
                          color: Colors.lightGreen,
                          child: FlatButton(
                            onPressed: () async {
                              setState(() {
                                upload(_image);
                              });
                            },
                            child: Text(
                              "UPLOAD",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                            width: 250,
                            height: 200,
                            child: _image == null
                                ? Text('No image selected.')
                                : Image.file(_image)),
                        Text("$result")
                      ],
                    ),
                    color: Colors.white,
                  ))
            ])
          ],
        )),
      ),
    );
  }
}
