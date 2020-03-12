import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/DatabaseService.dart';
import 'package:socialSuite/Core/FetchData.dart';
import 'package:socialSuite/Core/Models/IGUserModel.dart';
import 'package:socialSuite/Core/Models/User.dart';

import '../ConversionDate.dart';

class LostFollowers extends StatefulWidget {
  @override
  _LostFollowersState createState() => _LostFollowersState();
}

class _LostFollowersState extends State<LostFollowers> {
  Future<List<IGMyInsights>> lostFollowers;
  FetchData _fetchData = new FetchData();

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            lostFollowers = _fetchData.lostFollower(
                userData.username, userData.password, userData.userID);
            return FutureBuilder<List<IGMyInsights>>(
              future: lostFollowers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<IGMyInsights> posts = snapshot.data;
                  return new Column(
                      children: posts
                          .map((post) => new Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text("Lost Followers: " +
                                          post.lostFollowers_value),
                                      SizedBox(width: 10),
                                      Text("Date " +
                                          timestampToDate(
                                              post.lostFollower_label))
                                    ],
                                  )
                                ],
                              ))
                          .toList());
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        });
  }
}
