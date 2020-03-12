import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/DatabaseService.dart';
import 'package:socialSuite/Core/FetchData.dart';
import 'package:socialSuite/Core/Models/IGUserModel.dart';
import 'package:socialSuite/Core/Models/User.dart';

import '../ConversionDate.dart';
import '../users.dart';

class FollowersList extends StatefulWidget {
  @override
  _FollowersListState createState() => _FollowersListState();
}

class _FollowersListState extends State<FollowersList> {
  Future<List<IGMyFollowers>> followerList;
  FetchData _fetchData = new FetchData();

  @override
  Widget build(BuildContext context) {
  User user = Provider.of<User>(context);
  
 return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            followerList = _fetchData.followerList(userData.username, userData.password, userData.userID);
            return FutureBuilder<List<IGMyFollowers>>(
                future: followerList,
                builder: (context, snapshot) {
                if (snapshot.hasData){
                      List<IGMyFollowers> posts = snapshot.data;
                      return new Column(
                          children: posts.map((post) => new Column(
                            children: <Widget>[
                              Column(mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[
                                users(post.mediaURL, post.username)
                              ],)
                            ],
                          )).toList()
                      );
                    } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  // By default, show a loading spinner.
                  return CircularProgressIndicator();
                },
              );
          } else {
            return Center(child: Text("Loading..."),);
          }
        });
  }
}