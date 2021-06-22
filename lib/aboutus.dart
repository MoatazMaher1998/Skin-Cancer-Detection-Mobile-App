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
      "Tarekosama1998@gmail.com",
      "https://github.com/tarekosama126",
      "https://www.linkedin.com/in/tarek-osama-411756173/",
      "Facebook",
      "https://scontent-lhr8-1.xx.fbcdn.net/v/t1.6435-9/90117905_3066217290122159_7146900012327239680_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_eui2=AeHelBq9ueg8G1VZjOvb5pRWi7LT1V8xvRCLstPVXzG9EIyqOfpbALy83PocbLoR7sOtY1hhs51G6WF_yzZHCs9M&_nc_ohc=WHOru95B8F0AX_tewmi&_nc_ht=scontent-lhr8-1.xx&oh=3e46288d348f9d775390147f09c6bd50&oe=60BA270A",
      "Machine learning & Firebase"),
  Developer(
      "Ahmed Refaat",
      "ahmedrefaat0108@gmail.com",
      "https://github.com/Arefaat18",
      "https://www.linkedin.com/in/arefaat898/",
      "Facebook",
      "https://media-exp1.licdn.com/dms/image/C4D03AQEQ27LlgKbjAg/profile-displayphoto-shrink_800_800/0/1568723547203?e=1626307200&v=beta&t=RakO14yuUNr6nf5d-GdYM0V98b0mY3sbpSKLaJY7ltY",
      "APIs & Flutter Developer"),
  Developer(
      "Zeyad Mostafa",
      "zyadmostaf@gmail.com",
      "https://github.com/zeyadmostafa",
      "https://www.linkedin.com/in/zyad-mostafa-9bba47191",
      "Facebook",
      "https://scontent-hbe1-1.xx.fbcdn.net/v/t1.6435-9/41273894_2009817632402884_838337041623154688_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=BWqQ2cPsCRwAX8Gfjee&_nc_ht=scontent-hbe1-1.xx&oh=13ab8f05d26adc5755ca080b7a9327df&oe=60BF83E4",
      "Machine learning "),
  Developer(
      "Mohamed Aly Loutfy",
      "mohamedloutfy97@gmail.com",
      "https://github.com/MohamedAlyLoutfy",
      "https://www.linkedin.com/in/mohamed-ali-13b1111b2/",
      "Facebook",
      "https://avatars.githubusercontent.com/u/73834061?v=4",
      "Machine learning"),
  Developer(
      "Hossam Mohamed",
      "fahmyhossam98@gmail.com",
      "https://github.com/HossamJr",
      "https://eg.linkedin.com/in/hossam-fahmy-618461141",
      "Facebook",
      "https://media-exp1.licdn.com/dms/image/C4D03AQETEHuLc-g9dg/profile-displayphoto-shrink_800_800/0/1530281685734?e=1626307200&v=beta&t=V1kx9kXYWZwPV-_qd3AENIcKnFQPqE3wIyWS7aWvOFs",
      "Machine learning"),
  Developer(
      "Rashad Sallam",
      "rashadsallam98@gmail.com",
      "https://github.com/RashadSallam",
      "LinkedIn",
      "Facebook",
      "https://avatars.githubusercontent.com/u/65104512?v=4",
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
                      "Dr. Nayera Sadek \n\nDr. Ahmed Eltarras",
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
