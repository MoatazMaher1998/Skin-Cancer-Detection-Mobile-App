import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'upload.dart';
import 'aboutus.dart';
import 'login.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                  Tab(
                    icon: Icon(Icons.login),
                    text: 'Log in',
                  ),
                  Tab(
                    icon: Icon(Icons.read_more),
                    text: 'About Us',
                  ),
                ],
              ),
              toolbarHeight: 75,
            ),
            body: TabBarView(
              children: [Upload(), LoginScreen(), AboutUs()],
            ),
          ),
        ),
      ),
    );
  }
}

