
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_cancer_app/constants.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'package:intl/intl.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/cupertino.dart';

class AccountSettings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditSettingsState();
  }
}

class EditSettingsState extends State<AccountSettings> {
  final _firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  var _updateProfileformKey = GlobalKey<FormState>();
  var _updatePWformKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController DOBController = TextEditingController();
  String genderController = "MALE";
  // The way to retrieve the data ....

  @override
  void initState() {
    super.initState();
    getNameAndDateAndGender();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Settings'),
          backgroundColor: Colors.teal,
        ),
        body: ListView(shrinkWrap: true, children: <Widget>[
          Form(
            key: _updateProfileformKey,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
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
                            KTextFormField.copyWith(labelText: 'Your Name'),
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
                            return 'Please enter your password';
                          }
                        },
                        decoration: KTextFormField.copyWith(
                            labelText: 'Your Current Password'),
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
                      child: Row(
                        children: <Widget>[
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
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: CustomRadioButton(
                        width: 150,
                        elevation: 0,
                        defaultSelected: genderController,
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
                          print(value);
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
                        child: Text('Save'),
                        onPressed: () async {

                            if (_updateProfileformKey.currentState.validate()) {
                              //updateProfile();
                              debugPrint(
                                  "SUCCESS +$email+ ${nameController.text}  + ${DOBController.text} + $genderController");
                              if (nameController.text == userName && DOBController.text == dateOfBirth && genderController==gender){
                                print("No changes Happened");
                              }
                              else{

                                var res = EmailAuthProvider.credential(email: email, password: passwordController.text);
                                FirebaseAuth auth = FirebaseAuth.instance;
                                try{
                                  var data = await auth.currentUser.reauthenticateWithCredential(res);
                                  print("Correct Password has been entered");
                                  updateProfile();
                                }catch(e){
                                  print(e);
                                }
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
          Expanded(
            child: Form(
                key: _updatePWformKey,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              controller: oldPasswordController,
                              obscureText: true,
                              // ignore: missing_return
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter your old Password';
                                }
                              },
                              decoration: KTextFormField.copyWith(
                                  labelText: 'Old password'),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextFormField(
                              obscureText: true,
                              controller: newpasswordController,
                              // ignore: missing_return
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Please enter your new password';
                                }
                              },
                              decoration: KTextFormField.copyWith(
                                  labelText: 'New Password'),
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
                                if (value != newpasswordController.text)
                                  return 'Passwords do not match';
                              },
                              decoration: KTextFormField.copyWith(
                                  labelText: 'Confirm Password'),
                            ),
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.teal,
                              child: Text('Change Password'),
                              onPressed: () async{
                                if (_updatePWformKey.currentState.validate()) {
                                    debugPrint(
                                        "SUCCESS + ${oldPasswordController.text} + ${confirmPasswordController.text} + ${newpasswordController.text}");
                                    var res = EmailAuthProvider.credential(email: email, password: oldPasswordController.text.toString());
                                    FirebaseAuth auth = FirebaseAuth.instance;
                                    try{
                                      var data = await auth.currentUser.reauthenticateWithCredential(res);
                                      print("Correct Password has been entered");
                                      updatePassword();
                                    }catch(e){
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
                )),
          )
        ]));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
    DOBController.text = DateFormat.yMMMd().format(selectedDate);
  }
  String userName = "";
  String dateOfBirth = "";
  String gender = "";
  String documentId;
  String email;
  void getNameAndDateAndGender() async {
    bool result = await Userdetails().Userislogged();
    if (result == true) {
      userName = await Userdetails().getUserName();
      dateOfBirth = await Userdetails().getdataOfBirth();
      gender = await Userdetails().getGender();
      documentId = await Userdetails().getDocumentId();
      email = await Userdetails().getEmail();

      nameController.text = userName;
      DOBController.text = dateOfBirth;
      genderController = gender;
    }
  }

  void updateProfile() async {
    final user = await Userdetails().getCurrentUser();
    user.updateProfile(displayName: nameController.text);
    await _firestore
        .collection("Information")
        .doc(documentId)
        .update({"Gender": '$genderController',
    "DataOfBirth": DOBController.text.toString()
    });
    print("DATAA SAVED SUCCEFFULLYY");
  }
  void updatePassword() async{
    final user = await Userdetails().getCurrentUser();
    user.updatePassword(newpasswordController.text);
    print("Password Have beeen changedd");
  }
}
