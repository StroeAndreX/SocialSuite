import 'package:socialSuite/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService 
{
  final String username; 
  FirestoreService({ this.username });

  final CollectionReference userCollection = Firestore.instance.collection('User');

  Future<void> updateStandardUserData(String firstName, String lastName, String password, String email) async 
  {
    return await userCollection.document(username).setData({
        'firstName' : firstName,
        'lastName' : lastName, 
        'Password: ' : password,
        'Email: ' : email,  
    });
  } 
}

