import 'dart:io';

import 'package:flutter/material.dart';

Widget GetDeveloper(name, imgLink, linkedinLink, githubLink) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        width: 50,
        height: 60,
        child: Image.network(
          imgLink,
          fit: BoxFit.fill,
        ),
      ),
      Text(name),
      Text(linkedinLink),
      Text(githubLink)
    ],
  );
}

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
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
          Text(
              "We Are students in Faculty Of engineering Alexandria universty and this is our graduation project"),
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GetDeveloper(
                  "Moataz Maher",
                  "https://scontent.fcai21-4.fna.fbcdn.net/v/t31.18172-8/13669288_1295519147139792_3478302157419612104_o.jpg?_nc_cat=109&ccb=1-3&_nc_sid=a9b1d2&_nc_ohc=1rHBgqsV4ScAX_MjdH0&_nc_ht=scontent.fcai21-4.fna&oh=9ccc7209ca33ce965750cc6a0d35cd37&oe=60B3D102",
                  "LinkedIn",
                  "Github"),
              SizedBox(
                height: 7,
              ),
              GetDeveloper(
                  "Tarek Osama",
                  "https://scontent.fcai21-3.fna.fbcdn.net/v/t1.6435-9/90117905_3066217290122159_7146900012327239680_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Qq9IiWF23VYAX_bgDuO&_nc_ht=scontent.fcai21-3.fna&oh=1fd65dbc4d55cd0504606d1693fb847f&oe=60B6328A",
                  "LinkedIn",
                  "Github"),
              SizedBox(
                height: 7,
              ),
              GetDeveloper(
                  "Ahmed Reafat",
                  "https://scontent.fcai21-4.fna.fbcdn.net/v/t1.6435-9/172025596_4496883163660637_96996859299587546_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=LtbbVpnzQjYAX9UqCAn&_nc_oc=AQm6XZ3_5khpxGcoFJt4l1I0r2tW_PG9q2R74BeWuDY7jd68NLO_RnJwxf3h1A31Bqo&_nc_ht=scontent.fcai21-4.fna&oh=558c4169e6703bdcd5dda29b5d0cefb4&oe=60B3AA66",
                  "LinkedIn",
                  "Github"),
              SizedBox(
                height: 7,
              ),
              GetDeveloper(
                  "Zeyad Moustafa",
                  "https://scontent.fcai21-4.fna.fbcdn.net/v/t1.6435-1/p200x200/41273894_2009817632402884_838337041623154688_n.jpg?_nc_cat=111&ccb=1-3&_nc_sid=7206a8&_nc_ohc=rk2loOgtenYAX_Nl5wq&_nc_ht=scontent.fcai21-4.fna&tp=6&oh=0b1a05f1b26b0bfc2e5609c1b6b6d4f8&oe=60B393B3",
                  "LinkedIn",
                  "Github"),
              SizedBox(
                height: 7,
              ),
              GetDeveloper(
                  "Mohamed Lotfy",
                  "https://scontent.fcai21-3.fna.fbcdn.net/v/t1.6435-9/38152821_2334392366585793_7334298064041017344_n.jpg?_nc_cat=107&ccb=1-3&_nc_sid=8bfeb9&_nc_ohc=7zoJny0NkjsAX8PZ2db&tn=P0RK8l3wL9el2Rm0&_nc_ht=scontent.fcai21-3.fna&oh=7277a5bcef2ecdcd7f87e5b48cc995dc&oe=60B63906",
                  "LinkedIn",
                  "Github"),
              SizedBox(
                height: 7,
              ),
              GetDeveloper(
                  "Hossam Mohamed",
                  "https://scontent.fcai21-3.fna.fbcdn.net/v/t1.6435-9/46517117_10161110086745324_7120347626855202816_n.jpg?_nc_cat=110&ccb=1-3&_nc_sid=730e14&_nc_ohc=fp1vWCNZZUcAX_JBGlB&_nc_ht=scontent.fcai21-3.fna&oh=8bcdc642b15930ef4fdbd93beb18b83b&oe=60B35554",
                  "LinkedIn",
                  "Github"),
              SizedBox(
                height: 7,
              ),
              GetDeveloper(
                  "Rashad Sallam",
                  "https://scontent.fcai21-4.fna.fbcdn.net/v/t1.6435-9/54519668_420315902052688_850326515844382720_n.jpg?_nc_cat=102&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=-XEip8gWY1EAX8pqkyz&_nc_ht=scontent.fcai21-4.fna&oh=92ef89b82fbf7e944c9197a80e4e866d&oe=60B32FBC",
                  "LinkedIn",
                  "Github")
            ],
          )
        ]),
      ),
    );
  }
}
