import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'NavigationDrawer.dart';
import 'upload.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Cancer Detection '),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
          child: MyDrawer()// Populate the Drawer in the next step.
      ),
      body: Center(child: Upload()),
    );
  }
}

