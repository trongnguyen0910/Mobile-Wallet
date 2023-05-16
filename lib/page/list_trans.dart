import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swdproject/page/setting.dart';


class ListTrans extends StatelessWidget {
   String transId; //ok
  // final String img;
     int amount; //ok
    DateTime transactionDate; //ok
    String code; //ok
    String walletId; //ok
    String description; //ok
    String transFrom;
    String transTo;
    String status; //ok
    String? content;

  ListTrans({
    Key? key,
    required this.transId,
    required this.amount,
    required this.transactionDate,
    required this.code,
    required this.status,
    required this.walletId,
    required this.description,
    required this.transFrom,
    required this.transTo,
    required this.content,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Color.fromARGB(255, 160, 217, 246),
   child: Padding(
    padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
    child: Card(
        elevation: 5, // độ nâng của card
        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(8.0)),
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
                    "$transId",
                    style: TextStyle(
                     fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 10.0),
                     Row(
                    children: <Widget>[
                      Text(
                        "Amount: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "$amount",
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
                        DateFormat('dd-MM-yyyy hh-mm-ss').format(transactionDate),
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                   Row(
                    children: <Widget>[
                      Text(
                        "Content: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "$content",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Description: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "$description",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
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
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Code: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$code",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Wallet ID: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$walletId",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Transaction from: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$transFrom",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Transaction To: ",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "$transTo",
                        style: TextStyle(
                          fontSize: 14.0,
                          // fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    ),
    );
  
  }
}