import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'AccountSettings.dart';
import 'main.dart';

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
  void initState() {
    super.initState();
    getUser();
  }

  //final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String name;

  List<Test> dummyHistoryList = [
    Test(index: 0, date: "25.04.2021", result: "98% Positive"),
    Test(index: 1, date: "25.04.2021", result: "100% Negative"),
    Test(index: 2, date: "25.04.2021", result: "99% Positive"),
  ];

  void getUser() async {
    loggedInUser = await Userdetails().getCurrentUser();
    setState(() {
      name = loggedInUser.displayName;
    });
  }


  @override
  Widget build(BuildContext context) {
    //final _auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AccountSettings()),
                );
              }),
          SizedBox(width: 40),
          IconButton(
            onPressed: ()  {
              Userdetails().UserSignOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            splashColor: Colors.teal,
            iconSize: 30,
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            tooltip: 'Log out',
          )
        ],
        title: Text(
          "  $name",
          style: TextStyle(
            color: Colors.teal,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: ListView.builder(
              itemCount: dummyHistoryList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text('${dummyHistoryList[index].index}'),
                  title: Text('${dummyHistoryList[index].result}'),
                  trailing: Text('${dummyHistoryList[index].date}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
/*SafeArea(
child: Column(
children: [
Row(
children: [
Column(
children: [
Container(
margin:
EdgeInsets.symmetric(vertical: 35, horizontal: 20),
height: 35,
width: 140,
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
width: 140,
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
height: 130,
width: 130,
)
],
)
],
),*/
