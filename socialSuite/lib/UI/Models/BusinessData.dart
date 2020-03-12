import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socialSuite/Core/DatabaseService.dart';
import 'package:socialSuite/Core/FetchData.dart';
import 'package:socialSuite/Core/Models/BarChart.dart';
import 'package:socialSuite/Core/Models/IGUserModel.dart';
import 'package:socialSuite/Core/Models/User.dart';
import 'package:socialSuite/UI/Models/FetchData/newFollowers.dart';
import 'package:socialSuite/UI/Models/FetchData/reachedAccount.dart';

import 'ConversionDate.dart';
import 'FetchData/lostFollowers.dart';

class BusinessSection extends StatefulWidget {
  @override
  _BusinessSectionState createState() => _BusinessSectionState();
}

class _BusinessSectionState extends State<BusinessSection> {
  FetchData _fetchData = new FetchData();
  Future<List<IGMyInsights>> followersLost;
  Future<List<IGMyInsights>> reachedUsers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            followersLost = _fetchData.lostFollower(
                userData.username, userData.password, userData.userID);
            reachedUsers = _fetchData.accountsReacted(
                userData.username, userData.password, userData.userID);
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 70),
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData.profileImage),
                  ),
                  SizedBox(height: 5),
                  Text(userData.username),
                  SizedBox(height: 10),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Followers: " + followers.toString()),
                      SizedBox(width: 100),
                      Text("Following: " + following.toString()),
                    ],
                  )),
                  SizedBox(height: 15),
                  Text(
                    "New Followers: " ,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 10),
                  NewFollowers(),
                  SizedBox(height: 10),
                  Text(
                    "Lost Followers",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 10),
                  LostFollowers(),
                  SizedBox(height: 10),
                  Text(
                    "Reached Accounts",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(height: 10),
                  ReachedAccounts(),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Loading..."),
            );
          }
        });
  }
  final followers = 976;
  final following = 529;
}
