import 'package:flutter/material.dart';
import 'package:skin_cancer_app/AccountSettings.dart';
import 'package:skin_cancer_app/TestsHistory.dart';
import 'package:skin_cancer_app/dashboard.dart';
import 'package:skin_cancer_app/main.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('User X'),
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Dashboard()),
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => TestsHistory()),
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => AccountSettings()),
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
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyApp()),
                );
              },
            ),
          ],
        )
    );
  }
}