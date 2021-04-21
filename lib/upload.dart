import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Upload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: [
        SizedBox(height: 50),
        Row(children: <Widget>[
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "    Cancer",
                    style: TextStyle(
                        fontFamily: 'Zen Dots',
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                ),
                Expanded(child: Image.asset("images/logo.png")),
                Expanded(
                  child: Text(
                    "    Free",
                    style: TextStyle(
                        fontFamily: 'Zen Dots',
                        fontSize: 20,
                        color: Colors.teal),
                  ),
                )
              ],
            ),
          )
        ]),
        Row(children: <Widget>[
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
                        onPressed: () async {
                          var url = Uri.parse(
                              'https://api.algorithmia.com/v1/algo/moatazmaher/Skintest/1.0.0');
                          Map<String, String> headers = {
                            'Content-Type': 'application/json',
                            'authorization':
                                'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
                          };
                          final test = jsonEncode({
                            'matrix_a': [
                              [0, 1],
                              [2, 0]
                            ],
                            'matrix_b': [
                              [0, 1],
                              [2, 0]
                            ]
                          });

                          var response =
                              await http.post(url, body: test, headers: {
                            'Content-Type': 'application/json',
                            'Authorization':
                                'Simple sim+fZhO70XsHOvA0OMEnIFu8J91'
                          });
                          print('Response status: ${response.statusCode}');
                          print('Response body: ${response.body}');
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
              ))
        ])
      ],
    ));
  }
}
