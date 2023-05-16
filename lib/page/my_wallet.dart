import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyWallet extends StatelessWidget {
   String walletId;
   double balance;
   String status;
   String walletTypeName;
  


 MyWallet({
    Key? key,
    required this.walletId,
    required this.balance,
    required this.status,
    required this.walletTypeName,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
          width: 300,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 94, 94, 200),
            borderRadius: BorderRadius.circular(16),
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                SizedBox(height: 10,),
              Text('Balance',
              style: TextStyle(
                color: Colors.white
              ),
              ),
              SizedBox(height: 10,),
           
              Text('$balance',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
              ),
              SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$walletId',
                style: TextStyle(color: Colors.white,
                ),
                ),
                Text(
                  '$status',
                style: TextStyle(color: Colors.white,
                ),
                )
              ],
            ) ,
            SizedBox(height: 28,),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$walletTypeName',
                style: TextStyle(color: Colors.white,
                ),
                ),
              ],
            )  
            ],),
          ),
    )
        ;
  }
}