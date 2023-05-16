import 'package:flutter/material.dart';

import '../../models/Product.dart';
import '../../models/productfpt.dart';
import '../home/constants.dart';


class Description extends StatelessWidget {
  const Description({
    Key? key,
    required this.datum,
  }) : super(key: key);

  final Datum datum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      // child: Text(
      //   '${datum.description}',
      //   style: TextStyle(height: 1.5),
      // ),
    );
  }
}
