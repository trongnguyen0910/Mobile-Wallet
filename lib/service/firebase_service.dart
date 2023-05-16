import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdproject/page/profile.dart';
import 'dart:convert';

import '../models/person.dart';
import '../models/productfpt.dart';
import '../page/loginsuccess.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  // signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //     await _googleSignIn.signIn();
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;
  //       final AuthCredential authCredential = GoogleAuthProvider.credential(
  //           accessToken: googleSignInAuthentication.accessToken,
  //           idToken: googleSignInAuthentication.idToken);
  //       await _auth.signInWithCredential(authCredential);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     throw e;
  //   }
  // }
 
Future<void> signInWithGoogle() async {
  try {
    final GoogleSignInAccount? googleSignInAccount =
    await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
          FirebaseAuth fAuth = FirebaseAuth.instance;
      final User? firebaseUser =
            (await fAuth.signInWithCredential(authCredential).catchError((msg) {
        }))
                .user;
       if (firebaseUser != null) {
            String token = await firebaseUser.getIdToken();
            print('Get token from firebase: $token');
            await sendTokenToApi(token);
        if (token != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenfirebase', token);
  }
       }
       
      
    }
  } on FirebaseAuthException catch (e) {
    print(e.message);
    throw e;
  }
}

Future<void> sendTokenToApi( String token) async {
  final url = 'https://node-js-wallet-fpt-2.herokuapp.com/login';
  final prefs = await SharedPreferences.getInstance();
  // ignore: non_constant_identifier_names
  final TokenPusnoti = prefs.getString('token');
  final headers = {
    'Content-Type': 'application/json',
  };
  final body = json.encode({
    'token': token,
    "role": "customer",
    "device_token": TokenPusnoti,
  });
  final response = await http.post(Uri.parse(url), headers: headers, body: body);
  final responseData = json.decode(response.body);
  final accesstoken = responseData['access_token'];

 final walletBalance = responseData['data']['wallet']['wallet_balance'];
 final name = responseData['data']['name'];
 final phone = responseData['data']['phone'];
 final email = responseData['data']['email'];
 final walletType = responseData['data']['wallet']['wallet_type'];
 final idUser= responseData['data']['id'];
 final walletId =responseData['data']['wallet']['id'];

  print('AcessToken: $accesstoken');
  print('Token đã được gửi lên API. Dữ liệu trả về: $responseData');
  
  // Lưu trữ access token bằng Shared Preferences
  if (accesstoken != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accesstoken', accesstoken);
  }
  if (idUser != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('idUser', idUser);
  }
  if (walletId != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('walletId', walletId);
  }
  if (walletBalance != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('walletBalance', walletBalance);
  }
  if (name != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
  }
  if (phone != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', phone);
  }
  if (email != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
  if (walletType != null) {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('walletType', walletType);
  }
}
  // await getProduct(accesstoken);


// Future<List<Datum>> getProduct( String accesstoken) async {
//   final url = 'https://node-js-fpt-wallet.herokuapp.com/products';
//   Map<String, String> headers = {
//   'Authorization': 'Bearer $accesstoken',
//   'Content-Type': 'application/json',
// };
//   final response = await http.get(Uri.parse(url), headers: headers);
//   final responseProdcut = json.decode(response.body)['data'];
//   print('Dữ liệu trả về: $responseProdcut');
  
//   if(responseProdcut!=null){
//      final routes= List<Map<String, dynamic>>.from(responseProdcut);
//      return routes
//      .map((item) => Datum.fromJson(item))
//      .toList();
//   } else{
//     throw Exception("Failed");
//   }
 
// }







  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

