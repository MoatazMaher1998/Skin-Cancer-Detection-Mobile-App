import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dashboard.dart';
import 'constants.dart';

//TODO 1 Selected Gender is equal to null even after selecting it ...
//TODO 2 Save the rest of data from the form after saving the User...
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
  TextEditingController DOBController = TextEditingController();
  String genderController;

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      decoration: KTextFormField.copyWith(labelText: "Enter Your Name"),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter a valid e-mail address';
                        }
                      },
                      decoration: KTextFormField.copyWith(labelText: 'E-mail address'),
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
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                      obscureText: true,
                      controller: confirmPasswordController,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text)
                          return 'Passwords do not match';
                      },
                      decoration: KTextFormField.copyWith(labelText: 'Confirm Password'),
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your date of birth';
                        }
                      },
                      decoration: KTextFormField.copyWith(labelText: 'Date of Birth'),
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
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.teal,
                      child: Text('Sign Up'),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          debugPrint(
                              "SUCCESS + ${emailController.text} + ${nameController.text} + ${passwordController.text} + ${confirmPasswordController.text} + ${DOBController.text} + $genderController");
                          try {
                            setState(() {
                              showSpinner = true;
                            });

                            //TODO ADD to fireStore BOD
                            //TODO ADD to fireStore Gender
                            final newUser =
                                await _auth.createUserWithEmailAndPassword(
                                    email: emailController.text,
                                    password: passwordController.text);
                            newUser.user.updateProfile(
                                displayName: nameController.text, photoURL: "");
                            if (newUser != null) {
                              print("DONE ADDED TO DATABASE");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()),
                              );
                            }
                            setState(() {
                              showSpinner = false;
                            });
                          } catch (e) {
                            print(e);
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
        firstDate: DateTime(1925, 1),
        lastDate: DateTime(2022));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    DOBController.text = DateFormat.yMMMd().format(selectedDate);
  }
}
