import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Product.dart';
import '../../models/productfpt.dart';
import '../call_transaction.dart';
import '../errorpage.dart';
import '../home/constants.dart';
import '../thanksyoupage.dart';

class AddToCart extends StatefulWidget {
  AddToCart({Key? key, required this.datum}) : super(key: key);

  final Datum datum;

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  bool _isButtonDisabled = false;
  final TextEditingController quantityController = TextEditingController();

  _buyProduct() async {
    var quantity = quantityController.text;
    var quantityProduct = "${widget.datum.quantity}";

    if (quantity.isEmpty || int.parse(quantity) > int.parse(quantityProduct)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ErrorPage()),
      );
      return; // Dừng hàm và không gửi dữ liệu đến máy chủ
    }

    var data = {
      "products": [
        {
          "product_id": "${widget.datum.productId}",
          "quantity": quantity,
          "price": "${widget.datum.productPrice}",
        }
      ]
    };

    var res = await CallTransaction().postData(data, 'orders/products');

    // var body = json.decode(res.body);
    print('body: ${res.statusCode}');
    var body = '${res.statusCode}';
    if (body != '200') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ErrorPage()),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ThankYouPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 120,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.circular(18),
            //   border: Border.all(
            //     color: product.color,
            //   ),
            // ),
            child: TextField(
              controller: quantityController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(9),
                border: OutlineInputBorder(),
                labelText: 'Enter quantity',
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  backgroundColor: Color.fromARGB(255, 63, 204, 255),
                ),
                onPressed: () {
                  if (!_isButtonDisabled) {
                    _isButtonDisabled = true;
                    _buyProduct();
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('Error'),
                        content: Text('You clicked the button twice!!'),
                        actions: [
                          TextButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  // if(_buyProduct()!=null){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => const ThankYouPage()),
                  // );}
                },
                child: Text(
                  "Buy product".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
