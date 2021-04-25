import 'package:flutter/material.dart';
import 'NavigationDrawer.dart';
import 'upload.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Cancer Detector'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
          child: MyDrawer()// Populate the Drawer in the next step.
          ),
      body: Center(child: Upload()),
    );
  }
}
