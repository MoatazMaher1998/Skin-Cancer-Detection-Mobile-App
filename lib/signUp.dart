// import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'constants.dart';
import 'main.dart';


List<String> gender = ["Male", "Female"];

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignupState();
  }
}

class SignupState extends State<SignUp> {

  DateTime selectedDate = DateTime.now();
  bool showSpinner = false;
  var _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController DOBController = TextEditingController();
  String genderController = "MALE";
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 50,
        title: Text("Go Back"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Text(
                        'Create an account',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: nameController,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      decoration:
                          KTextFormField.copyWith(labelText: "Enter Your Name"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
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
                      decoration:
                          KTextFormField.copyWith(labelText: 'E-mail address'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter a password';
                        }
                      },
                      decoration:
                          KTextFormField.copyWith(labelText: 'Password'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text)
                          return 'Passwords do not match';
                      },
                      decoration: KTextFormField.copyWith(
                          labelText: 'Confirm Password'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: DOBController,
                      keyboardType: TextInputType.datetime,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        _selectDate(context);
                      },
                      // ignore: missing_return
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                      },
                      decoration:
                          KTextFormField.copyWith(labelText: 'Date of Birth'),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(children: <Widget>[
                        // Text("Gender",
                        //  style: TextStyle(fontSize: 15.0),),
                        // RadioGroup<String>.builder(
                        //   groupValue: genderController,
                        //   direction: Axis.horizontal,
                        //   onChanged: (value) => setState(() {
                        //     genderController = value;
                        //   }),
                        //   items: gender,
                        //   itemBuilder: (item) => RadioButtonBuilder(
                        //     item,
                        //   ),
                        // )
                      ])),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: CustomRadioButton(
                      width: 150,
                      elevation: 0,
                      defaultSelected: "MALE",
                      absoluteZeroSpacing: false,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        'Male',
                        'Female',
                      ],
                      buttonValues: [
                        "MALE",
                        "FEMALE",
                      ],
                      buttonTextStyle: ButtonTextStyle(
                          selectedColor: Colors.white,
                          unSelectedColor: Colors.black,
                          textStyle: TextStyle(fontSize: 16)),
                      radioButtonValue: (value) {
                        genderController = value;
                      },
                      selectedColor: Colors.teal,
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.teal,
                      child: Text('Sign Up'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          debugPrint(
                              "SUCCESS + ${emailController.text} + ${nameController.text} + ${passwordController.text} + ${confirmPasswordController.text} + ${DOBController.text.toString()} + $genderController");
                          try {
                            setState(() {
                              showSpinner = true;
                            });

                            // ADD New User to Authentication...
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: emailController.text.toLowerCase(),
                                    password: passwordController.text);
                            newUser.user.updateProfile(
                                displayName: nameController.text, photoURL: "");

                            if (newUser != null) {
                              //check about the user have been added or not
                              print("DONE ADDED TO DATABASE");
                              //Store the new User to FireStore..
                              await _firestore.collection("Information").add({
                                "DataOfBirth": DOBController.text.toString(),
                                "Gender": genderController,
                                "email": emailController.text.toString().toLowerCase(),
                                "result": {}
                              });
                              print("Dataa Saved to FireStore SUCESS");
                              // change the layput to MyApp
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()),
                              );
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print(
                                  'The account already exists for that email.');
                              // ignore: deprecated_member_use
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                content: new Text(
                                    'Error: The account already exists for that email.'),
                                duration: new Duration(seconds: 10),
                              ));
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            print("error $e");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1910, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    DOBController.text = DateFormat.yMMMd().format(selectedDate);
  }
}
