import 'package:cloud_firestore/cloud_firestore.dart';

import 'Models/User.dart';

class DatabaseService {

  final String uid; 
  DatabaseService({ this.uid });

  final CollectionReference userCollection = Firestore.instance.collection('User');

  Future<void> setFirebaseUser(String email, String password) async 
  {
    return await userCollection.document(uid).setData({
      'email': email,
      'password': password, 
    });
  }

  Future<void> updateFirebaseUser(String username, String password, Map<String, dynamic> json) async 
  {
    //String userID = json['Data']['feed']['items'][0]['caption']['user']['pk'] ?? '';
    int userID = json["Data"]["feed"]["items"][0]["caption"]["user"]["pk"] as int;
    String profileImage = json["Data"]["feed"]["items"][0]["caption"]["user"]["profile_pic_url"] as String;

    return await userCollection.document(uid).updateData({
      'InstagramUsername': username,
      'InstagramPassword': password, 
      'userID': userID,
      'profileImage': profileImage, 
    });
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      userID: snapshot.data['userID'],
      username: snapshot.data['InstagramUsername'],
      password: snapshot.data['InstagramPassword'],
      profileImage: snapshot.data['profileImage']
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }


}