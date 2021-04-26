import 'package:firebase_auth/firebase_auth.dart';
class Userdetails{
  User loggedInUser;
  Future<User> getCurrentUser(FirebaseAuth auth ) async {
    try {
      final user = await auth.currentUser;
      //print(user);
      if (user != null) {
        loggedInUser = user ;
      }
      else{
        print("No User Is Valid");
        throw "No User";
      }

    }catch(e){
      print(e);
    }
    return loggedInUser;
  }
}