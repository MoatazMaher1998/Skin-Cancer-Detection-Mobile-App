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

  String name;

  List<Test> dummyHistoryList = [
    Test(index: 0, date: "25.04.2021", result: "98% Positive"),
    Test(index: 1, date: "25.04.2021", result: "100% Negative"),
    Test(index: 2, date: "25.04.2021", result: "99% Positive"),
  ];

  void getUser() async {
    bool result = await Userdetails().Userislogged();
    if (result == true) {
      String username = await Userdetails().getUserName();

      setState(() {
        name = username;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
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
            fontSize: 23,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: dummyHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Image.network(
                  "https://alexunicovidapi.s3-eu-west-1.amazonaws.com/moatazmaher1998%40gmail.com/1.jpg"),
              title: Text('${dummyHistoryList[index].result}'),
              trailing: Text('${dummyHistoryList[index].date}'),
            );
          },
        ),
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
