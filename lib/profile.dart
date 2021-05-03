import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skin_cancer_app/aboutus.dart';

class Profile extends StatefulWidget {
  final Developer developer;
  const Profile({Key key, this.developer}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('${widget.developer.name}')),
        backgroundColor: Colors.blue,
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
          )
        ],
      ),
    );
  }
}
