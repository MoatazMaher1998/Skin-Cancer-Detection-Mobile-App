import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_cancer_app/constants.dart';
import 'package:skin_cancer_app/userdetails.dart';
import 'NavigationDrawer.dart';
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
  //final _firestore = FirebaseFirestore.instance;
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
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        backgroundColor: Colors.teal,
      ),

      body: ListView(
          shrinkWrap: true,
        children: <Widget>[
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
                    decoration: KTextFormField.copyWith(labelText: 'Your Name'),
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
                    decoration:
                        KTextFormField.copyWith(labelText: 'Your Current Password'),
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
                    onPressed: () {
                      setState(() {
                        if (_updateProfileformKey.currentState.validate()) {
                          //updateProfile();
                          debugPrint(
                              "SUCCESS + ${emailController.text} + ${nameController.text} + ${newpasswordController.text} + ${confirmPasswordController.text} + ${DOBController.text} + $genderController");
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
          Expanded( child: Form(
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
                        // ignore: missing_return
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your old Password';
                          }
                        },
                        decoration: KTextFormField.copyWith(labelText: 'Old password'),
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
                        decoration:
                            KTextFormField.copyWith(labelText: 'New Password'),
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
                        decoration:
                            KTextFormField.copyWith(labelText: 'Confirm Password'),
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
                        onPressed: () {
                          setState(() {
                            if (_updatePWformKey.currentState.validate()) {
                              debugPrint(
                                  "SUCCESS + ${emailController.text} + ${nameController.text} + ${newpasswordController.text} + ${confirmPasswordController.text} + ${DOBController.text} + $genderController");
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
          )])

    );
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

  void getUser() async {
    bool result = await Userdetails().Userislogged();
    if (result == true) {
      String username = await Userdetails().getUserName();
      String dateofBirth = await Userdetails().getdataOfBirth();
      String gender = await Userdetails().getGender();
      nameController.text = username;
      DOBController.text = dateofBirth;
      genderController = gender;
    }
  }

  void updateProfile() async {
    final user = await Userdetails().getCurrentUser();

  }
}
