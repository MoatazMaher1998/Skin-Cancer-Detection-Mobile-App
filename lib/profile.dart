import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/aboutus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'linkedin_icon_icons.dart';
import 'github_icons.dart';

class Profile extends StatefulWidget {
  final Developer developer;
  const Profile({Key key, this.developer}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white60,
              backgroundImage: NetworkImage("${widget.developer.image}"),
            ),
            Text("${widget.developer.name}",
                style: TextStyle(
                    fontFamily: "Pacifico",
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text("${widget.developer.role}",
                style: TextStyle(
                    fontFamily: "SourceSansPro",
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Container(
              color: Colors.white,
              margin: EdgeInsets.all(25.0),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.teal.shade900,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.developer.email}",
                    style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 15,
                        fontFamily: "SourceSansPro"),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                launch(widget.developer.linkedin);
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  children: [
                    Icon(
                      LinkedinIcon.linkedin_in,
                      color: Colors.teal.shade900,
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "LinkedIn Profile",
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 18,
                          fontFamily: "SourceSansPro"),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                launch(widget.developer.github);
              },
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  children: [
                    Icon(
                      githubIcon.github,
                      color: Colors.teal.shade900,
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "Github Profile",
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 18,
                          fontFamily: "SourceSansPro"),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text("${widget.developer.role}"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("${widget.developer.image}"),
                      fit: BoxFit.fill,
                    ),
                    shape: BoxShape.circle,
                  ),
                  height: 200,
                  width: 200,
                ),
              )
            ],
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("  ${widget.developer.name}"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("  ${widget.developer.email}"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("  ${widget.developer.linkedin}"),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("  ${widget.developer.github}"),
            ],
          ),
        ],
      ),
    );*/
