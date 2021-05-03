import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Developer {
  final String name;
  final String image;
  final String email;
  final String github;
  final String linkedin;
  final String facebook;
  final String role;
  Developer(this.name, this.email, this.github, this.linkedin, this.facebook,
      this.image, this.role);
}

List<Developer> DevelopersList = [
  Developer("Moataz Maher", "Moatazmaher1998@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "Backend & Flutter Developer"),
  Developer("Tarek Osama", "TarekOsama@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "Machine learning & Firebase"),
  Developer("Ahmed Refeat", "Ahmedrefeat122@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "API's & Flutter Developer"),
  Developer("Zeyad Mostafa", "ZeyadMoustafa1111@gmail.com", "Github",
      "LinkedIn", "Facebook", "Image", "Machine learning "),
  Developer("Mohamed Lotfy", "TarekOsama@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "Machine learning"),
  Developer("Hossam Moh.", "TarekOsama@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "Machine learning"),
  Developer("Rashad Sallam", "TarekOsama@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "Machine learning"),
];
TableRow GetDeveloper(Developer devInfo) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          "   ${devInfo.name}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text("   ${devInfo.role}")),
      ),
    ],
  );
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    child: Image.asset(
                      "images/Alexulogo.png",
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Image.asset("images/faculty.png"),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 320,
                child: Center(
                  child: Text(
                    "We are students in Faculty Of Engineering Alexandria University and this is our graduation project",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(children: [
                Table(
                    columnWidths: const <int, TableColumnWidth>{
                      0: FlexColumnWidth(130),
                      1: FlexColumnWidth(230),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      GetDeveloper(DevelopersList[0]),
                      GetDeveloper(DevelopersList[1]),
                      GetDeveloper(DevelopersList[2]),
                      GetDeveloper(DevelopersList[3]),
                      GetDeveloper(DevelopersList[4]),
                      GetDeveloper(DevelopersList[5]),
                      GetDeveloper(DevelopersList[6]),
                    ]),
                SizedBox(height: 20),
                Text(
                  "Supervised By",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  "Dr. Nayera Mohammed \n\n Dr. Ahmed ELtarras",
                  style: TextStyle(fontSize: 15),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
//  TableR
//  leading: Container(
//    width: 55,
//    height: 55,
//    child: Image.network(
//      '${dummyHistoryList[index].imagePath}',
//      fit: BoxFit.fill,
//    ),
//  ),
//  title: Text(
//      '${dummyHistoryList[index].result} Skin Cancer {type}'),

// trailing: Text('${dummyHistoryList[index].date}'),
