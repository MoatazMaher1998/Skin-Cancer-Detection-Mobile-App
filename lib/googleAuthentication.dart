import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'FirstScreen.dart';

final _firestore = FirebaseFirestore.instance;

class googleAuthentication {

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/user.birthday.read',
      'https://www.googleapis.com/auth/user.gender.read'
    ],
  );
  Future<List> _getGenderandDOB() async {
    final headers = await _googleSignIn.currentUser.authHeaders;
    final r = await http.get(
        Uri.parse(
            "https://people.googleapis.com/v1/people/me?personFields=genders,birthdays&key="),
        headers: {"Authorization": headers["Authorization"]});
    final response = jsonDecode(r.body);
    String birthdate = response["birthdays"][1]["date"]["day"].toString() +
        "/" +
        response["birthdays"][1]["date"]["month"].toString() +
        "/" +
        response["birthdays"][1]["date"]["year"].toString();
    return [response["genders"][0]["formattedValue"], birthdate];
  }

  Future<void> handleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      final UserCredential googleUserCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (googleUserCredential.additionalUserInfo.isNewUser) {
        googleUserCredential.user.updateProfile(
            displayName: googleUserCredential.user.displayName,
            photoURL: googleUserCredential.user.photoURL);
        List userData = await _getGenderandDOB();
        await _firestore.collection("Information").add({
          "DataOfBirth": userData[1],
          "Gender": userData[0],
          "email": googleUserCredential.user.email,
          "result": {},
        });
      }
    } catch (error) {
      print(error);
    }
  }

 Future<void> handleSignOut() async{
    _googleSignIn.disconnect();
   _googleSignIn.signOut();
 }
}