import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skin_cancer_app/constants.dart';
import 'package:skin_cancer_app/dashboard.dart';
import 'signUp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:http/http.dart" as http;

import 'dart:async';
import 'dart:convert' show json;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return LoginState();
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '300830567303-1i5fo70r8rc8499b4uih06t3uqp1no7o.apps.googleusercontent.com',
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);




class LoginState extends State<LoginScreen> {

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = "Loading contact info...";
    });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      setState(() {
        _contactText = "People API gave a ${response.statusCode} "
            "response. Check logs for details.";
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    final String namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = "I see you know $namedContact!";
      } else {
        _contactText = "No contacts to display.";
      }
    });
  }

  String _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic> connections = data['connections'];
    final Map<String, dynamic> contact = connections.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    );
    if (contact != null) {
      final Map<String, dynamic> name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      );
      if (name != null) {
        return name['displayName'];
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      debugPrint("TEST error");
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  bool showSpinner = false;

  Widget _buildBody() {
    GoogleSignInAccount user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text("Signed in successfully."),
          Text(_contactText),
          ElevatedButton(
            child: const Text('SIGN OUT'),
            onPressed: _handleSignOut,
          ),
          ElevatedButton(
            child: const Text('REFRESH'),
            onPressed: () => _handleGetContact(user),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ElevatedButton(
            child: RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                     child:  Image.asset('images/googleLogo.png',width:20,height:20),
                    ),
                  TextSpan(
                    text: " Sign in using Google",
                  ),
                ],
              ),
            )
            ,
            onPressed: _handleSignIn,
          ),
        ],
      );
    }
  }


  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  GoogleSignInAccount _currentUser;
  String _contactText = '';
  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser);
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Form (
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Log in',
                            style: TextStyle(fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                            if (!emailValid) {
                              return 'Please enter a valid e-mail address';
                            }
                          },
                          decoration: KTextFormField.copyWith(labelText: 'E-mail address') ,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          obscureText: true,
                          controller: passwordController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a password';
                            }
                          },
                          decoration: KTextFormField.copyWith(labelText: 'Password'),
                        ),
                      ),
                      FlatButton(
                        onPressed: (){
                          //forgot password screen
                        },
                        textColor: Colors.teal,
                        child: Text('Forgot Password'),
                      ),
                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.teal,
                            child: Text('Login'),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                print(emailController.text);
                                print(passwordController.text);
                                try{
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  final occurUser = await _auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                                  if (occurUser != null){
                                    print("User Occur at DataBase");
                                    Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder: (context) => Dashboard()),
                                    );
                                  }
                                  setState(() {
                                    showSpinner = false;
                                  });
                                }catch(e) {
                                  print(e);
                                }
                              }

                            },
                          )),
                      Container(
                          child: Row(
                            children: <Widget>[
                              Text("Don't have an account?"),
                              FlatButton(
                                textColor: Colors.teal,
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  //signup screen
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SignUp()),
                                  );
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
                      Container(
                        child: _buildBody()
                      )
                    ],
                  ))),
        ));
  }}