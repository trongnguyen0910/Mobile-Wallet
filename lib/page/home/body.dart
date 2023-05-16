import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Product.dart';
import '../../models/productfpt.dart';
import '../detail/details_screen.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;

import 'categorries.dart';
import 'item_card.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final scrollController = ScrollController();
  List<Datum> productList = [];
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: productList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                controller: scrollController,
                itemCount: productList.length + (isLoading ? 1 : 0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index == productList.length) {
                    if (isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return Container();
                    }
                  } else {
                    return ItemCard(
                      productId: productList[index].productId,
                      image: productList[index].image,
                      productPrice: productList[index].productPrice,
                      productName: productList[index].productName,
                      press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            datum: productList[index],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }

  Future<void> _getProduct() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accesstoken');
    final url = 'https://node-js-fpt-wallet.herokuapp.com/products?page=$page';
    Map<String, String> headers = {
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json',
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    final responseProduct = json.decode(response.body)['data'];
    if (responseProduct != null) {
      final routes = List<Map<String, dynamic>>.from(responseProduct);
      final newProductList = routes.map((item) => Datum.fromJson(item)).toList();
      setState(() {
        productList.addAll(newProductList);
      });
    } else {
      throw Exception("Failed");
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        page = page + 1;
        _getProduct().then((_) {
          setState(() {
            isLoading = false;
          });
        });
      }
    }
  }
}
