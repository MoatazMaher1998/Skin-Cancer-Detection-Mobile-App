import 'package:flutter/material.dart';

class Upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "    Cancer",
                  style: TextStyle(
                      fontFamily: 'Zen Dots', fontSize: 20, color: Colors.teal),
                ),
              ),
              Expanded(child: Image.asset("images/logo.png")),
              Expanded(
                child: Text(
                  "    Free",
                  style: TextStyle(
                      fontFamily: 'Zen Dots', fontSize: 20, color: Colors.teal),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  width: 250,
                  color: Colors.lightGreen,
                  child: FlatButton(
                    onPressed: () {
                      // add actions here
                    },
                    child: Text(
                      "UPLOAD",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  width: 250,
                  height: 200,
                  child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed viverra vestibulum risus at porttitor. Suspendisse et iaculis quam, ac tempor est. Phasellus condimentum finibus pulvinar. In luctus metus a eleifend pellentesque."),
                )
              ],
            ),
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
