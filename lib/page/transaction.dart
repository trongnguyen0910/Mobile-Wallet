import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';
import 'package:http/http.dart' as http;

import '../models/transaction.dart';
import 'list_order.dart';
import 'list_trans.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key? key}) : super(key: key);

  @override
  State<Transaction> createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  List<TransactionWallet> transList = [];
  @override
  Widget build(BuildContext context) {
     return FutureBuilder<List<TransactionWallet>>(
      future: getTrans(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TransactionWallet> trans = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView.builder(
              itemCount: trans.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTrans(
                  transId: trans[index].transId,
                  amount: trans[index].amount,
                  transactionDate: trans[index].transactionDate,
                  code: trans[index].code,
                  walletId: trans[index].walletId,
                  description: trans[index].description,
                  transFrom: trans[index].transFrom,
                  transTo: trans[index].transTo,
                  status: trans[index].status,
                  content: trans[index].content,
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
Future<List<TransactionWallet>> getTrans() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accesstoken');
  final walletId = prefs.getString('walletId');
  final url = 'https://node-js-wallet-fpt-2.herokuapp.com/transactions/history?id=$walletId&page=1';
  Map<String, String> headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };
  final response = await http.get(Uri.parse(url), headers: headers);
  final responseTrans = json.decode(response.body)['data'];
  print('Dữ liệu trả về: $responseTrans');
  
  if(responseTrans != null){
    if(responseTrans is List){
      return responseTrans
        .map((item) => TransactionWallet.fromJson(item))
        .toList();
    } else if(responseTrans is Map<String, dynamic>){
      return [TransactionWallet.fromJson(responseTrans)];
    } else {
      throw Exception("Invalid response format");
    }
  } else {
    throw Exception("Failed");
  }
}

// Future<List<OrderProduct>> getOrder() async {
//    final prefs = await SharedPreferences.getInstance();
//    final accessToken = prefs.getString('accesstoken');
//     final url = 'https://node-js-wallet-fpt-2.herokuapp.com/orders/{id}';
//    Map<String, String> headers = {
//   'Authorization': 'Bearer $accessToken',
//    'Content-Type': 'application/json',
//   };
//    final response = await http.get(Uri.parse(url), headers: headers);

//     final responseOrder = json.decode(response.body) as List;
//     // print('responseData: $responseData');
//     if (response.statusCode == 200) {
//       return responseOrder.map((e) => OrderProduct.fromJson(e)).toList();
//     } else {
//       throw Exception("Fail to fetch");
//     }
//   }


