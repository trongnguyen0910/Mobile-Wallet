// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../home.dart';
import '../page/profile.dart';


class UploadSuccess extends StatefulWidget {
  const UploadSuccess({Key? key}) : super(key: key);

 

  @override
  State<UploadSuccess> createState() => _UploadSuccessState();
}

Color themeColor = Color.fromARGB(255, 255, 0, 0);

class _UploadSuccessState extends State<UploadSuccess> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 170,
              padding: EdgeInsets.all(35),
              decoration: BoxDecoration(
               
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                "assets/images/success.gif",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: screenHeight * 0.1),
            Text(
              "Update Successful !",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
           
            SizedBox(height: screenHeight * 0.05),
            Text(
              "Click here to return to home",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
           ElevatedButton.icon(
          onPressed: () {
             Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
          },
            label: Text('Home'),
            icon: Icon(Icons.person),
        ),
       
          ],
        ),
      ),
    );
  }
}