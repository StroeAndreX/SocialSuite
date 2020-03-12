

import 'package:firebase_auth/firebase_auth.dart';
import 'package:socialSuite/Core/DatabaseService.dart';

import 'Models/User.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _returnFirebaseUser(FirebaseUser user) {
      return (user != null) ? User(uid: user.uid): null; 
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_returnFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async
  {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      return _returnFirebaseUser(user);

    } 
    catch(e)
    {
      throw Exception("Can't login");
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      print(user.uid);

      await DatabaseService(uid: result.user.uid).setFirebaseUser(email, password);
      return _returnFirebaseUser(user);
    }
    catch(e)
    {
      print("Error: " + e);
    }
  }

  Future signOut() async {

    try {
      return _auth.signOut();
    }
    catch(e)
    {
      throw Exception("Bad Request");
    }

  }


}