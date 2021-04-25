import 'package:flutter/material.dart';
import 'NavigationDrawer.dart';
import 'upload.dart';


class Test {
  final String result;
  final int index;
  final String date;

  Test({this.index, this.result, this.date});
}

class TestsHistory extends StatelessWidget {

  List<Test> dummyHistoryList = [
    Test(index: 0, date: "25.04.2021", result: "98% Positive"),
    Test(index: 1, date: "25.04.2021", result: "100% Negative"),
    Test(index: 2, date: "25.04.2021", result: "99% Positive"),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests History'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
          child: MyDrawer()// Populate the Drawer in the next step.
      ),
      body: Center(
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
      ),
    );
  }
}
