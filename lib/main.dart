import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 50,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.image_rounded),
                    text: 'Upload Image',
                  ),
                  Tab(
                    icon: Icon(Icons.login),
                    text: 'Log in',
                  ),
                  Tab(
                    icon: Icon(Icons.read_more),
                    text: 'About Us',
                  ),
                ],
              ),
              toolbarHeight: 75,
            ),
            body: TabBarView(
              children: [Test1(), Test2(), Test3()],
            ),
          ),
        ),
      ),
    );
  }
}

class Test2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Test3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Test1 extends StatelessWidget {
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
      ],
    );
  }
}
