import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Userdetails {
  User _loggedInUser;
  final _firestore = FirebaseFirestore.instance;
  // ignore: non_constant_identifier_names
  var Usermessage;
  final _auth = FirebaseAuth.instance;
  String _email;
  // ignore: non_constant_identifier_names
  String _DataOfBirth;
  String _Gender;
  String _documentId;
  Map<String, dynamic> _results;
  int _lengthOfResults;

  Future<User> _getCurrentUser() async {
    final user = await _auth.currentUser;
    _loggedInUser = user;
    return _loggedInUser;
  }

  void getData() async {
    _loggedInUser = await _getCurrentUser();
    var document = await _firestore.collection('Information').get();
    var messages = document.docs;
    //print(messages);
    for (var message in messages) {
      //print(document.docs.length);
      //print(message.id);
      var dataEmails = message.data()["email"].toString();
      //print(dataEmails);
      //print(_loggedInUser.email);
      if (dataEmails == _loggedInUser.email) {
        Usermessage = await message;
        _documentId = await message.id;
        break;
      }
    }
    parseUserData();
  }

  void parseUserData() {
    _email = Usermessage["email"].toString();
    _Gender = Usermessage["Gender"].toString();
    _DataOfBirth = Usermessage["DataOfBirth"].toString();
    _results = Usermessage["result"];
    _lengthOfResults = _results.length;
    // print(_email);
    // print(_Gender);
    // print(_DataOfBirth);
    // print(_results);
    // print(_lengthOfResults);
  }

  Future<String> getEmail() async {
    await getData();
    return _email;
  }

  Future<String> getdataOfBirth() async {
    await getData();
    return _DataOfBirth;
  }

  Future<String> getGender() async {
    await getData();
    return _Gender;
  }

  Future<Map<String, dynamic>> getresults() async {
    await getData();
    return _results;
  }

  Future<int> getlength() async {
    await getData();
    return _lengthOfResults;
  }

  void UserSignOut() async {
    await _auth.signOut();
  }

  Future<String> getDocumentId() async {
    await getData();
    return _documentId;
  }

  Future<bool> Userislogged() async {
    _loggedInUser = await _getCurrentUser();
    if (_loggedInUser == null) {
      return false;
    }
    return true;
  }

  Future<String> getUserName() async {
    _loggedInUser = await _getCurrentUser();
    return _loggedInUser.displayName.toString();
  }
}
