import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Models/IGUserModel.dart';

class IGUserData {

  final String igUsername;
  final String igPassword; 

  IGUserData({ this.igUsername, this.igPassword });

  Future<IGMyData> fetchMyIGData() async {
    final response = await http.get('https://socialsuite.herokuapp.com/api/self_data' + igUsername + "/" + igPassword);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return IGMyData.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load api');
    }
  }

  Future<IGMyFollowers> fetchMyMedia() async {
    final response = await http.get('https://socialsuite.herokuapp.com/api/self_data' + igUsername + "/" + igPassword);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return IGMyFollowers.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load api');
    }
  }

}