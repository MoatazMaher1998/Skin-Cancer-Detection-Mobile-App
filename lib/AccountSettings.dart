import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skin_cancer_app/constants.dart';
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
  final _firestore = FirebaseFirestore.instance;
  DateTime selectedDate = DateTime.now();
  var _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  String genderController;
  // The way to retrieve the data ....
  void getData() async {
    var document = await _firestore.collection('Information').get();
    for (var message in document.docs) {
      print(message.data());
    }
  }
  // Method to Update the Databaase....
  void setData() async {
    await _firestore.collection("Information").add({
      "DataOfBirth": "06/20/1998",
      "Gender": "Male",
      "email": "ahmed@gmail.com",
      "result" : {
        "result2" : "negative 50%",
        "result1" : "Postive 60%",
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    setData();
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Settings'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(child: MyDrawer() // Populate the Drawer in the next step.
          ),
      body: Form(
        key: _formKey,
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
                        controller: oldPasswordController,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter your old password';
                          }
                        },
                        decoration: KTextFormField.copyWith(labelText: 'Old Password'),
                      ),
                    ),
                    Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextFormField(
                    obscureText: true,
                    controller: newpasswordController,
                    validator: (String value) {
                    if (value.isEmpty) {
                    return 'Please enter your new password';
                    }
                    },
                    decoration: KTextFormField.copyWith(labelText: 'New Password'),
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
                          if (value != newpasswordController.text)
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
                          print(value);
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
                          child: Text('Save'),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                debugPrint(
                                    "SUCCESS + ${emailController.text} + ${nameController.text} + ${newpasswordController.text} + ${confirmPasswordController.text} + ${DOBController.text} + $genderController");
                              }
                            });
                          },
                        )),
                  ],
                ),),),),);
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


}
