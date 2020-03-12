import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:socialSuite/Core/DatabaseService.dart';

import 'Models/IGUserModel.dart'; 

class RESTFULApi {

  final url = "http://socialsuite.herokuapp.com/api/";

  Future login(String username, String password, String uid) async
  {
    final response = await http.get(url + "self_data/" + username + "/" + password);

    if (response.statusCode == 200) {
     // If the server did return a 200 OK response, then parse the JSON.

      return await DatabaseService(uid: uid).updateFirebaseUser(username, password, jsonDecode(response.body));
    } else {
     // If the server did not return a 200 OK response, then throw an exception.
     throw Exception('Failed to login');
    } 
  }
}