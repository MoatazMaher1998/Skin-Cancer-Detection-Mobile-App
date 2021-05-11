import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skin_cancer_app/FirstScreen.dart';
import 'package:skin_cancer_app/googleAuthentication.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'signUp.dart';
import 'package:google_sign_in/google_sign_in.dart';
import "package:http/http.dart" as http;
import 'dart:io' show Platform;
import 'dart:async';
import 'dart:convert' show json;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
final _firestore = FirebaseFirestore.instance;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginScreen> {

  Future<void> _handleSignIn() async {
    try {
      await googleAuthentication().handleSignIn();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FirstScreen()),
      );
    } catch (error) {
      print(error);
    }
  }

  bool showSpinner = false;
  bool _obscureText = true;

  var _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String errorMessage;
  GlobalKey<ScaffoldState> showError(String error) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text(error),
      duration: new Duration(seconds: 10),
    ));
  }

  GoogleSignInAccount _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
            key: _formKey,
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 100.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        // ignore: missing_return
                        validator: (String value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return 'Please enter a valid e-mail address';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Email',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter a password';
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Password',
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 15.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              semanticLabel: _obscureText
                                  ? "show password"
                                  : 'hide password',
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      onPressed: () async {
                        if (emailController.text == null ||
                            emailController.text == "") {
                          showError('Error: Have to enter the email first.');
                        } else {
                          bool emailOccur = await Userdetails()
                              .checkEmail(emailController.text);
                          if (emailOccur == false) {
                            showError(
                                "There is no account with this email please Sign Up");
                          } else {
                            //showError("Please check your email and reset password then return to re-login with your new password");
                            _auth
                                .sendPasswordResetEmail(
                                  email: emailController.text,
                                )
                                .then((onVal) {})
                                .whenComplete(() {
                              _showMyDialog(context,
                                  "Please check your email and reset password then return to re-login with your new password");
                            }).catchError((onError) {
                              if (onError
                                  .toString()
                                  .contains("ERROR_USER_NOT_FOUND")) {
                                print("User Not Found");
                              } else if (onError
                                  .toString()
                                  .contains("An internal error has occurred")) {
                                print("Internal Error");
                              }
                            });
                          }
                        }
                      },
                      textColor: Colors.teal,
                      child: Text('Forgot Password'),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(0, 160, 227, 1))),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            print(emailController.text);
                            print(passwordController.text);
                            try {
                              setState(() {
                                showSpinner = true;
                              });
                              final occurUser =
                                  await _auth.signInWithEmailAndPassword(
                                      email: emailController.text.toLowerCase(),
                                      password: passwordController.text);
                              if (occurUser != null) {
                                //print("User Occur at DataBase");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FirstScreen()),
                                );
                              }
                              setState(() {
                                showSpinner = false;
                              });
                            } catch (e) {
                              String errorMessage;
                              if (Platform.isAndroid) {
                                switch (e.message) {
                                  case 'There is no user record corresponding to this identifier. The user may have been deleted.':
                                    errorMessage =
                                        "There is no user with this e-mail address";
                                    break;
                                  case 'The password is invalid or the user does not have a password.':
                                    errorMessage = "The password is incorrect";
                                    break;
                                  case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
                                    errorMessage =
                                        "A Network error has occurred. Please Try Again";
                                    break;
                                  // ...
                                  default:
                                    print(
                                        'Case ${e.message} is not yet implemented');
                                }
                              } else if (Platform.isIOS) {
                                switch (e.code) {
                                  case 'Error 17011':
                                    errorMessage =
                                        "There is no user with this e-mail address";
                                    break;
                                  case 'Error 17009':
                                    errorMessage = "The password is incorrect";
                                    break;
                                  case 'Error 17020':
                                    errorMessage =
                                        "A Network error has occurred. Please Try Again";
                                    break;
                                  default:
                                    print(
                                        'Case ${e.message} is not yet implemented');
                                }
                              }
                              print('The error is $errorMessage');
                              // ignore: deprecated_member_use
                              showError('Error: $errorMessage');
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          }
                        },
                        padding: EdgeInsets.all(10.0),
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: Text("Login", style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Container(
                        child: Row(
                      children: <Widget>[
                        Text("Don't have an account?"),
                        // ignore: deprecated_member_use
                        FlatButton(
                          textColor: Colors.teal,
                          child: Text(
                            'Sign up',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    )),
                    Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        ElevatedButton(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Image.asset('images/googleLogo.png',
                                      width: 20, height: 20),
                                ),
                                TextSpan(
                                  text: " Sign in using Google",
                                ),
                              ],
                            ),
                          ),
                          onPressed: _handleSignIn,
                        ),
                      ],
                    ))
                  ],
                ))),
      ),
    );
  }

  Future<void> _showMyDialog(context, String line) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notify'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$line'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Proceed'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => FirstScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
