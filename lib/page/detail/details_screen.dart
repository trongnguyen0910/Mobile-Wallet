import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:swdproject/page/detail/body.dart';




import '../../models/Product.dart';
import '../../models/productfpt.dart';
import '../home/constants.dart';

class DetailsScreen extends StatelessWidget {
  // final Product product;
  final Datum datum;
  const DetailsScreen({Key? key, required this.datum}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: Color.fromARGB(255, 63, 204, 255),
      appBar: buildAppBar(context),
      body: Body(datum: datum),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 63, 204, 255),
      elevation: 0,
      // leading: IconButton(
      //   // icon: SvgPicture.asset(
      //   //   'assets/icons/back.svg',
      //   //   color: Colors.white,
      //   // ),
      //   onPressed: () => Navigator.pop(context),
      // ),
      actions: <Widget>[
        // IconButton(
        //   icon: SvgPicture.asset("assets/icons/search.svg"),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: SvgPicture.asset("assets/icons/cart.svg"),
        //   onPressed: () {},
        // ),
        SizedBox(width: kDefaultPaddin / 2)
      ],
    );
  }
}
