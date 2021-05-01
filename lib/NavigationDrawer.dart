import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/AccountSettings.dart';
import 'package:skin_cancer_app/TestsHistory.dart';
import 'package:skin_cancer_app/dashboard.dart';
import 'package:skin_cancer_app/main.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'package:skin_cancer_app/CustomListTile.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  //final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;
  void getUser() async {
    loggedInUser = await Userdetails().getCurrentUser();
    // print("!!!!!!!!!!!!!!!");
    // print(loggedInUser);
    // print("NAMEEEEE");
    // print(loggedInUser.displayName);
    setState(() {
      name = loggedInUser.displayName;
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
    final _auth = FirebaseAuth.instance;
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
        CustomListTile(
          title: "Make A Test",
          ontap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
        ),
        CustomListTile(
            title: "Test History",
            ontap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestsHistory()),
              );
            }),
        CustomListTile(
            title: "AccountSettings",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountSettings()),
              );
            }),
        CustomListTile(
            title: "Log Out",
            ontap: () async {
              await _auth.signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            }),
      ],
    ));
  }
}
