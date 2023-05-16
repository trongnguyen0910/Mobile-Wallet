import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';
import 'package:http/http.dart' as http;

import 'list_order.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<OrderProduct> orderList = [];
  @override
  Widget build(BuildContext context) {
     return FutureBuilder<List<OrderProduct>>(
      future: getOrder(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<OrderProduct> order = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView.builder(
              itemCount: order.length,
              itemBuilder: (BuildContext context, int index) {
                return ListOrder(
                  trans_order_id: order[index].transOrderId,
                  trans_order_date: order[index].transOrderDate,
                  total_amount: order[index].totalAmount,
                  status: order[index].status,
                  fullName: order[index].fullName,
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
Future<List<OrderProduct>> getOrder() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accesstoken');
  final idUser = prefs.getString('idUser');
  final url = 'http://node-js-wallet-fpt-2.herokuapp.com/orders';
  Map<String, String> headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json',
  };
  final response = await http.get(Uri.parse(url), headers: headers);
  final responseOrder = json.decode(response.body)['data'];
  print('Dữ liệu trả về: $responseOrder');
  
  if(responseOrder != null){
    if(responseOrder is List){
      return responseOrder
        .map((item) => OrderProduct.fromJson(item))
        .toList();
    } else if(responseOrder is Map<String, dynamic>){
      return [OrderProduct.fromJson(responseOrder)];
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


