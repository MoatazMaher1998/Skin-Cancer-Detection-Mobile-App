import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:skin_cancer_app/userdetails.dart';
import 'dart:convert';
import 'constants.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File _image;
  final picker = ImagePicker();
  var result;
  bool showSpinner = false;
  final _firestore = FirebaseFirestore.instance;

  Future _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _getImageFromMemory() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _upload(File imageFile, context) async {
    bool isLoggedin = await Userdetails().Userislogged();
    if (_image == null) {
      _showMyDialog(context, "noimage");
      setState(() {
        showSpinner = false;
      });
      return;
    }

    if (isLoggedin == false) {
      _showMyDialog(context, "loginError");
      setState(() {
        showSpinner = false;
      });
      return;
    }
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse(
        "https://skincancerapi-alexuni.herokuapp.com/API?Email=$userEmail&TestNumber=$lengthOfResults&Format=jpg");
    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
      setState(() {
        result = value;
        showSpinner = false;
        _showMyDialog(context, "result");
        return;
      });
    });
  }

  Future<void> _showMyDialog(context, String type) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        if (type == "result") {
          return AlertDialog(
            title: Text('Your Result is Ready!!!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('$result'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Proceed'),
                onPressed: () {
                  addToFireStore();
                  setState(() {
                    _image = null;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else if (type == "noimage") {
          return AlertDialog(
            title: Text('No Image Selected !'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Please Select An Image'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Proceed'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('Please Login First'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('You need to login before uploading images'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Login'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }

  Widget Animation(String text) {
    return TypewriterAnimatedTextKit(
      text: [text],
      speed: const Duration(milliseconds: 70),
      textStyle: KTextStyleCancer,
    );
  }

  Map<String, dynamic> resultsOfUser;
  int lengthOfResults;
  String userEmail;
  String documentId;
  void getResultAndLength() async {
    bool result = await Userdetails().Userislogged();
    if (result == true) {
      userEmail = await Userdetails().getEmail();
      lengthOfResults = await Userdetails().getlength() + 1;
      resultsOfUser = await Userdetails().getresults();
      documentId = await Userdetails().getDocumentId();
      print(resultsOfUser);
      print(lengthOfResults);
      print(userEmail);
      print(documentId);
    }
  }
  String format = "jpg";
  void addToFireStore() async {
    print(resultsOfUser);
    Map <String,dynamic> resultCombine = resultsOfUser;
    Map<String,dynamic> newPart = {
      "result$lengthOfResults":{
        "Image": "$lengthOfResults.$format",
        "cellType": "0",
        "date": DateTime.now().toString(),
        "percentage": "$result"
      }
    };
    resultCombine.addAll(newPart);
    print(resultCombine);
    await _firestore.collection("Information").doc(documentId).update({
      "result": resultCombine
    }) ;
  }

  @override
  void initState() {
    super.initState();
    getResultAndLength();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "Add from Memory",
              backgroundColor: Colors.teal,
              onPressed: _getImageFromMemory,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "Add from Camera",
              backgroundColor: Colors.teal,
              onPressed: _getImageFromCamera,
              child: Icon(Icons.add_a_photo),
            )
          ],
        ),
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(
            child: ListView(
              children: [
                SizedBox(height: 70),
                Row(children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Animation("  Cancer"),
                        ),
                        Expanded(child: Image.asset("images/logo.png")),
                        Expanded(
                          child: Animation("    Free"),
                        )
                      ],
                    ),
                  )
                ]),
                Row(
                  children: <Widget>[
                    Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            children: [
                              //  SizedBox(height: 30),
                              //  Text("Upload Your Skin "),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 50),
                                width: 250,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(0, 160, 227, 1))),
                                  onPressed: () {
                                    setState(() {
                                      showSpinner = true;
                                      _upload(_image, context);

                                    });
                                  },
                                  padding: EdgeInsets.all(10.0),
                                  color: Colors.teal,
                                  textColor: Colors.white,
                                  child: Text("Upload",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ),
                              Container(
                                  width: 250,
                                  height: 160,
                                  child: _image == null
                                      ? null
                                      : Image.file(_image)),
                            ],
                          ),
                          color: Colors.white,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
