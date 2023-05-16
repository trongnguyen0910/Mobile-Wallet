import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdproject/page/send_money.dart';
import 'package:swdproject/service/firebase_service.dart';

import '../models/person.dart';
import '../models/productfpt.dart';
import '../uploadFile/upload_image.dart';
import 'info_card.dart';

const wallet="";
const id = "9fgPnwBQ3agkN20jWxUQckejs7i2";
const name = "Nguyễn Trọng Nguyên";
const email = "nguyenntse151227@fpt.edu.vn";
const phone = "0898983892"; // not real number :)

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);
  
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isHovering = false;
   late String imageUrl = '';
   late int walletBalance=0;
   late String name = '';
   late String phone = '';
   late String email = '';
   late String walletType = '';
    late String token='';
 @override
  void initState() {
    super.initState();
   
     SharedPreferences.getInstance().then((prefs) {
  if (prefs != null) {
    setState(() {
      token = prefs.getString('tokenfirebase') ?? '';
    });
    final apiHelper = FirebaseServices();
    apiHelper.sendTokenToApi(token);
  }
});
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        imageUrl = prefs.getString('imageUrl') ?? '';
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        walletBalance = prefs.getInt('walletBalance') ?? 0;
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('name') ?? '';
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        phone = prefs.getString('phone') ?? '';
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        email = prefs.getString('email') ?? '';
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        walletType = prefs.getString('walletType') ?? '';
      });
    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      
      // backgroundColor: Color.fromARGB(255, 244, 245, 245),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageUploaderWidget()));
              },
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage:NetworkImage(imageUrl.isNotEmpty
                        ? imageUrl
                        : FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                  Positioned(
                    top: 70,
                    right: 2,
                    child: Icon(
                      Icons.edit_square,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            Text(
              '${name}',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.blueGrey[200],
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Source Sans Pro"),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),

            // we will be creating a new widget name info carrd
            InfoCard(text: '${walletType}', icon: Icons.info, onPressed: () async {}),
            InfoCard(text: '${walletBalance}', icon: Icons.wallet, onPressed: () async {}),
            InfoCard(text: '${name}', icon: Icons.person, onPressed: () async {}),
            InfoCard(text: '${phone}', icon: Icons.phone, onPressed: () async {}),
            InfoCard(text: '${email}', icon: Icons.email, onPressed: () async {}),
             
          ],
        ),
      ),
      // floatingActionButton: ElevatedButton.icon(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => SendMoney()));
      //   },
      //   label: Text('Send money'),
      //   icon: Icon(Icons.send),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}


