import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/AccountSettings.dart';
import 'package:skin_cancer_app/TestsHistory.dart';
import 'package:skin_cancer_app/dashboard.dart';
import 'package:skin_cancer_app/main.dart';
import 'package:skin_cancer_app/userdetails.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;
  void getUser() async {
    loggedInUser = await Userdetails().getCurrentUser(_auth);
    // print("!!!!!!!!!!!!!!!");
    // print(loggedInUser);
    // print("NAMEEEEE");
    // print(loggedInUser.displayName);
    setState(() {
      name  = loggedInUser.displayName;
    });

    //print(name);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) {

    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text(
            '$name',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Make a new Test'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            //Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Dashboard()),
            );
          },
        ),
        ListTile(
          title: Text('Tests History'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TestsHistory()),
            );
          },
        ),
        ListTile(
          title: Text('Account Settings'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AccountSettings()),
            );
          },
        ),
        ListTile(
          title: Text('Log Out'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ],
    ));
  }
}
