import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'AccountSettings.dart';
import 'NavigationDrawer.dart';
import 'main.dart';
import 'upload.dart';

class Test {
  final String result;
  final int index;
  final String date;

  Test({this.index, this.result, this.date});
}

class TestsHistory extends StatefulWidget {
  @override
  _TestsHistory createState() => _TestsHistory();
}

class _TestsHistory extends State<TestsHistory> {
  List<Test> dummyHistoryList = [
    Test(index: 0, date: "25.04.2021", result: "98% Positive"),
    Test(index: 1, date: "25.04.2021", result: "100% Negative"),
    Test(index: 2, date: "25.04.2021", result: "99% Positive"),
  ];
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    loggedInUser = await Userdetails().getCurrentUser(_auth);
    setState(() {
      name = loggedInUser.displayName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "$name",
          style: TextStyle(color: Colors.teal),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                      height: 35,
                      width: 160,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AccountSettings()),
                          );
                        },
                        textColor: Colors.white,
                        color: Colors.blue.shade900,
                        child: Text('Account Settings'),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                      height: 35,
                      width: 160,
                      child: RaisedButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                          );
                        },
                        textColor: Colors.white,
                        color: Colors.red.shade900,
                        child: Text('Log Out'),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Container(
                  color: Colors.blue,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
/*ListView(
children: <Widget>[
Container(
child: ListView.builder(
itemCount: dummyHistoryList.length,
itemBuilder: (context, index) {
return ListTile(
leading: Text('${dummyHistoryList[index].index}'),
title: Text('${dummyHistoryList[index].result}'),
trailing: Text('${dummyHistoryList[index].date}'),
);
},
),
),*/
