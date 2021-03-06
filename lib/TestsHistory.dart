import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skin_cancer_app/googleAuthentication.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'AccountSettings.dart';
import 'main.dart';

class Test {
  final String result;
  final String imagePath;
  final String date;

  Test({this.imagePath, this.result, this.date});
}

class TestsHistory extends StatefulWidget {
  @override
  _TestsHistory createState() => _TestsHistory();
}

class _TestsHistory extends State<TestsHistory> {
  String name;
  Map<String, dynamic> results;
  int lengthOfResults;
  List<Test> dummyHistoryList = [];
  String email;
  bool showSpinner = true;
  void initState() {
    super.initState();
    getUser();
  }

  void createTheListView() {
    if (lengthOfResults == 0) {
      setState(() {
        showSpinner = false;
      });
    } else {
      String Source = "https://alexunicovidapi.s3-eu-west-1.amazonaws.com/";
      for (MapEntry e in results.entries) {
        var Date = e.value["date"].toString().split(" ")[0];
        var percentage = "${e.value["percentage"].toString().substring(0, 4)}";
        var image = e.value["Image"].toString();
        email = email.replaceAll("@", "%40");
        String Path = "$Source$email/$image";
        dummyHistoryList
            .add(Test(imagePath: Path, result: percentage, date: Date));
      }
      setState(() {
        showSpinner = false;
      });
    }
  }

  void getUser() async {
    bool result = await Userdetails().Userislogged();
    if (result == true) {
      String username = await Userdetails().getUserName();
      results = await Userdetails().getresults();
      lengthOfResults = await Userdetails().getlength();
      email = await Userdetails().getEmail();
      setState(() {
        name = username;
      });
    }
    createTheListView();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      color: Colors.black,
      opacity: 0.9,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                iconSize: 30,
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onPressed: () {
                  // Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountSettings()),
                  );
                }),
            SizedBox(width: 40),
            IconButton(
              onPressed: () async {
                await googleAuthentication().handleSignOut;
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
          title: name == null
              ? Text("")
              : Text(
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
                leading: Container(
                  width: 55,
                  height: 55,
                  child: Image.network(
                    '${dummyHistoryList[index].imagePath}',
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text('${dummyHistoryList[index].result}% Skin Cancer'),
                trailing: Text('${dummyHistoryList[index].date}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
