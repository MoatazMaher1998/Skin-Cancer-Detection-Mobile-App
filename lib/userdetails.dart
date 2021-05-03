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

  Future<User> getCurrentUser() async {
    final user = await _auth.currentUser;
    _loggedInUser = user;
    return _loggedInUser;
  }

  void getData() async {
    _loggedInUser = await getCurrentUser();
    var document = await _firestore.collection('Information').get();
    var messages = document.docs;
    for (var message in messages) {
      var dataEmails = message.data()["email"].toString();
      if (dataEmails == _loggedInUser.email) {
        Usermessage = await message;
        _documentId = await message.id;
        break;
      }
    }
    parseUserData();
  }
  Future<bool> checkEmail(String email) async{
    var document = await _firestore.collection('Information').get();
    var messages = document.docs;
    for (var message in messages) {
      var dataEmails = message.data()["email"].toString();
      if (dataEmails == email) {
        return true;
      }
    }
    return false;
  }

  void parseUserData() {
    _email = Usermessage["email"].toString();
    _Gender = Usermessage["Gender"].toString();
    _DataOfBirth = Usermessage["DataOfBirth"].toString();
    _results = Usermessage["result"];
    _lengthOfResults = _results.length;
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
    _loggedInUser = await getCurrentUser();
    if (_loggedInUser == null) {
      return false;
    }
    return true;
  }

  Future<String> getUserName() async {
    _loggedInUser = await getCurrentUser();
    return _loggedInUser.displayName.toString();
  }
}
