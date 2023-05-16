import 'package:flutter/material.dart';


import '../../models/Product.dart';
import 'constants.dart';

class ItemCard extends StatelessWidget {
  
  final VoidCallback press;
   String productId;
    String productName;
    String? image;
    int productPrice;
    
   ItemCard({
    required this.productId,
    required this.productName,
    required this.image,
   required this.productPrice,
    required this.press,
  });

  @override
  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: press,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // set mainAxisSize to min
      children: <Widget>[
        Flexible(
          fit: FlexFit.loose, // use FlexFit.loose instead of Expanded
          child: Container(
            padding: EdgeInsets.all(kDefaultPaddin),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 181, 228, 248),
              borderRadius: BorderRadius.circular(16),
            ),
             child: Hero(
                tag: "$productId",
                child: image != null
      ? Image.network('$image')
      : Image.asset('assets/images/google.png'),
              ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
          child: Text(
            "$productName",
            style: TextStyle(color: kTextLightColor),
          ),
        ),
        Text(
          "Price: $productPrice",
          style: TextStyle(fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}

}
