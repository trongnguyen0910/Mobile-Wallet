import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ListOrder extends StatelessWidget {
  final String trans_order_id;
  // final String img;
   DateTime trans_order_date;
  int total_amount;
  final String status;
  final String fullName;


  ListOrder({
    Key? key,
    required this.trans_order_id,
    // required this.img,
    required this.trans_order_date,
    required this.total_amount,
    required this.status,
    required this.fullName,
    
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
      child: InkWell(
        // onTap: () {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (BuildContext context) {
        //         return HomePage();
        //       },
        //     ),
        //   );
        // },
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 0.0, right: 10.0),
              child: Container(
                height: MediaQuery.of(context).size.width / 3.5,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "$trans_order_id",
                    style: TextStyle(
                     fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10.0),
                     Row(
                    children: <Widget>[
                      Text(
                        "Full name: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "$fullName",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 19, 2),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Order date: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        DateFormat('dd-MM-yyyy hh-mm-ss').format(trans_order_date),
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 19, 2),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Total amount: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "$total_amount",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Color.fromARGB(255, 255, 3, 3),
                        ),
                      ),
                    ],
                  ),
                   Row(
                    children: <Widget>[
                      Text(
                        "Status: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$status",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  )
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}