// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:swdproject/models/transaction.dart';
import 'package:swdproject/page/my_wallet.dart';
import 'package:swdproject/page/transaction.dart';

import '../models/wallet.dart';
import 'package:http/http.dart' as http;

import 'home/constants.dart';
class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final _controller=PageController();
   List<Walletcus> walletList = [];
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[300],
    body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(
                  'My Wallet',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.wallet)
              ],
            ),
          ),
          SizedBox(height: 25),
          FutureBuilder<List<Walletcus>>(
            future: getWallet(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Walletcus> wallet = snapshot.data!;
                return SizedBox(
                  height: 200, // Set a fixed height for the PageView
                  child: PageView.builder(
                    controller: _controller,
                    scrollDirection: Axis.horizontal,
                    itemCount: wallet.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MyWallet(
                        balance: wallet[index].balance,
                        walletId: wallet[index].walletId,
                        status: wallet[index].status,
                        walletTypeName: wallet[index].walletTypeName,
                      );
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          SizedBox(height: 25),
          SmoothPageIndicator(
            controller: _controller,
            count: 2,
            effect: ExpandingDotsEffect(
              activeDotColor: Colors.grey.shade800,
            ),
          ),
           SizedBox(height: 100),
         ElevatedButton.icon(
  onPressed: () {
      Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Transaction()));
  },
  icon: Icon(Icons.history_sharp),
  label: Text(
    'History Transaction',
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  
),

        ],
      ),
    ),
  );
}

}
Future<List<Walletcus>> getWallet() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accesstoken');
  final idUser = prefs.getString('idUser');
  final url = 'https://node-js-wallet-fpt-2.herokuapp.com/users/$idUser/wallets';
  Map<String, String> headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };
  final response = await http.get(Uri.parse(url), headers: headers);
  final responseWallet = json.decode(response.body)['data'];
  print('Dữ liệu trả về: $responseWallet');
  
  if(responseWallet != null){
    if(responseWallet is List){
      return responseWallet
        .map((item) => Walletcus.fromJson(item))
        .toList();
    } else if(responseWallet is Map<String, dynamic>){
      return [Walletcus.fromJson(responseWallet)];
    } else {
      throw Exception("Invalid response format");
    }
  } else {
    throw Exception("Failed");
  }
}
