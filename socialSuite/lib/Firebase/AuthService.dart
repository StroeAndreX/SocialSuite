import 'package:socialSuite/Firebase/FirestoreService.dart';
import 'package:socialSuite/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

    //User Object
  User _returnFirebaseUser(FirebaseUser user)
  {
    return user != null ? User(uid: user.uid): null; 
  } 

  //Stream between app and Firebase -> Track the AuthUser state
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_returnFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _returnFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    } 
  }

  // register with email and password 
  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      UserUpdateInfo _userInfo = new UserUpdateInfo();
      _userInfo.displayName = username; 
      await user.updateProfile(_userInfo);
      await user.reload(); 
      
      await FirestoreService(username: username).updateStandardUserData("Andrei", username, password, email);
      return _returnFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }  

  //SignOut 
  Future signOut() async
  {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null; 
    }
  }

}