import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialSuite/Core/DatabaseService.dart';

import 'Models/IGUserModel.dart';

class FetchData {
  final localUrl = "http://socialsuite.herokuapp.com/api/";

  Future<List<IGMyInsights>> lostFollower(String username, String password, int userID) async {
    final response = await http.get(localUrl + "insights/" + username + "/" + password);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var responseJson = json.decode(response.body);

      return (responseJson['Data']['data']['user']['business_manager']
                  ['account_insights_unit']['metric_graph']['nodes'][1]
              ['data_points'] as List)
          .map((p) => IGMyInsights.lostFollowes(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      print('Failed to login');
    }
  }

  Future<List<IGMyInsights>> newFollowers(String username, String password, int userID) async {
    final response = await http.get(localUrl + "insights/" + username + "/" + password);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var responseJson = json.decode(response.body);

      return (responseJson['Data']['data']['user']['business_manager']
                  ['account_insights_unit']['metric_graph']['nodes'][0]
              ['data_points'] as List)
          .map((p) => IGMyInsights.newFollower(p))
          .toList();
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      print('Failed to login');
    }
  }

    Future<List<IGMyInsights>> accountsReacted(String username, String password, int userID) async {
      final response =
          await http.get(localUrl + "insights/" + username + "/" + password);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response, then parse the JSON.
        var responseJson = json.decode(response.body);

        return (responseJson['Data']['data']['user']['business_manager']['account_insights_unit']['account_discovery_graph']['nodes'][0]['data_points'] as List)
            .map((p) => IGMyInsights.usersReached(p))
            .toList();
      } else {
        // If the server did not return a 200 OK response, then throw an exception.
        print('Failed to login');
      }
    }

    Future<List<IGMyFollowers>> followerList(String username, String password, int userID) async {
      final response =
          await http.get(localUrl + "follower_list/" + username + "/" + password);

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response, then parse the JSON.
        var responseJson = json.decode(response.body);

        return (responseJson["Data:"] as List)
            .map((p) => IGMyFollowers.fromJson(p))
            .toList();
      } else {
        // If the server did not return a 200 OK response, then throw an exception.
        print('Failed to login');
      }
    }
  }

