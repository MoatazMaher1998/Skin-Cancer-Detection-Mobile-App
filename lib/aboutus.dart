import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/profile.dart';

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
  Developer(
      "Moataz Maher",
      "Moatazmaher1998@gmail.com",
      "https://github.com/MoatazMaher1998",
      "https://www.linkedin.com/in/moataz-maher-58a2b8146/",
      "Facebook",
      "https://scontent.faly3-2.fna.fbcdn.net/v/t1.18169-9/22815545_1907949472563420_7551933613333064338_n.jpg?_nc_cat=105&ccb=1-3&_nc_sid=174925&_nc_ohc=b0EINSzLYgIAX_aCIcq&_nc_ht=scontent.faly3-2.fna&oh=9595706e0a87ec679f564b0885784fd7&oe=60B58C5C",
      "Backend & Flutter Developer"),
  Developer(
      "Tarek Osama",
      "TarekOsama@gmail.com",
      "Github",
      "LinkedIn",
      "Facebook",
      "https://scontent.faly3-2.fna.fbcdn.net/v/t1.18169-9/995810_484478471629400_234129684_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=de6eea&_nc_ohc=kZLsALB7ZioAX9Ixsop&_nc_ht=scontent.faly3-2.fna&oh=ef8a89537d1cc6a4c1eaacf2c0fee18b&oe=60B7475D",
      "Machine learning & Firebase"),
  Developer(
      "Ahmed Refaat",
      "Ahmedrefeat122@gmail.com",
      "Github",
      "LinkedIn",
      "Facebook",
      "https://scontent.faly3-2.fna.fbcdn.net/v/t1.18169-9/10500304_10152137883526525_1504206721351615353_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=cdbe9c&_nc_ohc=nK80OJsjLRAAX-yTWTh&_nc_ht=scontent.faly3-2.fna&oh=deefc33f1207c8ecd621904dd8d99df3&oe=60B5B1D8",
      "API's & Flutter Developer"),
  Developer(
      "Zeyad Mostafa",
      "ZeyadMoustafa1111@gmail.com",
      "Github",
      "LinkedIn",
      "Facebook",
      "https://scontent.faly3-2.fna.fbcdn.net/v/t31.18172-8/10448611_748231351894858_2653410489194491622_o.jpg?_nc_cat=108&ccb=1-3&_nc_sid=ba80b0&_nc_ohc=ilTVAc90bDgAX-SN8Id&_nc_ht=scontent.faly3-2.fna&oh=b2984456cac7bf8d60a124d1291af9d9&oe=60B46BB2",
      "Machine learning "),
  Developer("Mohamed Lotfy", "TarekOsama@gmail.com", "Github", "LinkedIn",
      "Facebook", "Image", "Machine learning"),
  Developer(
      "Hossam Moh.",
      "TarekOsama@gmail.com",
      "Github",
      "LinkedIn",
      "Facebook",
      "https://scontent.faly3-2.fna.fbcdn.net/v/t1.18169-9/1546178_763548063673161_36130896_n.jpg?_nc_cat=103&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=C4ENrFVItn4AX_WWEwP&_nc_ht=scontent.faly3-2.fna&oh=0e5d149c30b9e2f210ef366d8bff3bba&oe=60B5E4C5",
      "Machine learning"),
  Developer(
      "Rashad Sallam",
      "TarekOsama@gmail.com",
      "Github",
      "LinkedIn",
      "Facebook",
      "https://scontent.faly3-2.fna.fbcdn.net/v/t1.18169-9/1488665_724760300882349_2098786387_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=cdbe9c&_nc_ohc=YnuV6-ya9igAX-gtZ4n&_nc_ht=scontent.faly3-2.fna&oh=36cd735777548be5594e3093572a847a&oe=60B5EA87",
      "Machine learning"),
];

class AboutUs extends StatefulWidget {
  @override
  _AboutUs createState() => _AboutUs();
}

class _AboutUs extends State<AboutUs> {
  // ignore: non_constant_identifier_names
  DataRow GetDeveloper(Developer devInfo) {
    return DataRow(
      cells: <DataCell>[
        DataCell(
            Text(
              '${devInfo.name}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ), onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(developer: devInfo)),
          );
        }),
        DataCell(Text('${devInfo.role}')),
      ],
    );
  }

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
              flex: 10,
              child: Column(children: [
                DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Name',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Main Role',
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                  dataRowHeight: 40,
                  horizontalMargin: 2,
                  rows: <DataRow>[
                    GetDeveloper(DevelopersList[0]),
                    GetDeveloper(DevelopersList[1]),
                    GetDeveloper(DevelopersList[2]),
                    GetDeveloper(DevelopersList[3]),
                    GetDeveloper(DevelopersList[4]),
                    GetDeveloper(DevelopersList[5]),
                    GetDeveloper(DevelopersList[6])
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "       Supervised By",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 55),
                    Text(
                      "Dr. Nayera  \n\nDr. Ahmed ELtarras",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
