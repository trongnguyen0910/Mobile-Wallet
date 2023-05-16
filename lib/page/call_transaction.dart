import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallTransaction{
  
  final String _url ="https://node-js-wallet-fpt-2.herokuapp.com/";
  postData(data, apiUrl) async{
    var fullUrl=_url+apiUrl;
    return await http.post(
      Uri.parse(fullUrl),
      body: jsonEncode(data),
      headers: await _setHeaders(),
    );

  }
}
 Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accesstoken');
  }
 
 Future<Map<String, String>> _setHeaders() async {
    var headers = <String, String>{
      'Content-Type': 'application/json',
    };
    var accessToken = await _getAccessToken();
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
    
  }