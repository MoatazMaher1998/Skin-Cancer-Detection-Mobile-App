import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/TestsHistory.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'upload.dart';
import 'aboutus.dart';
import 'login.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreen createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  String name;
  void getUser() async {
    bool result = await Userdetails().Userislogged();
    if (result == true){
      String username = await Userdetails().getUserName();
      setState((){
        name = username;
      });
    }

  }

  /* Widget loginProfileClassifier2(String type) {
    if (name == null) {
      if (type == "Class") {
        return LoginScreen();
      } else if (type == "Tab") {
        return Tab(
          icon: Icon(Icons.login),
          text: 'Log in',
        );
      }
    } else if (name != null) {
      if (type == "Class") {
        return TestsHistory();
      } else if (type == "Tab") {
        Tab(
          icon: Icon(Icons.add),
          text: 'Profile',
        );
      }
    }
  }
*/
  Widget loginProfileClassifier() {
    if (name == null) {
      return LoginScreen();
    } else {
      return TestsHistory();
    }
  }

  Widget loginProfileWidget() {
    if (name == null) {
      return Tab(
        icon: Icon(Icons.login),
        text: 'Log in',
      );
    } else {
      return Tab(
        icon: Icon(Icons.person),
        text: 'Profile',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 50,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.image_rounded),
                    text: 'Upload Image',
                  ),
                  loginProfileWidget(),
                  Tab(
                    icon: Icon(Icons.read_more),
                    text: 'About Us',
                  ),
                ],
              ),
              toolbarHeight: 75,
            ),
            body: TabBarView(
              children: [Upload(), loginProfileClassifier(), AboutUs()],
            ),
          ),
        ),
      ),
    );
  }
}
