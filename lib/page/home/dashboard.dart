// import 'package:flutter/material.dart';

// class Dashboard extends StatefulWidget {
//   const Dashboard({Key? key}) : super(key: key);

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(centerTitle: true,
//           elevation: 0, automaticallyImplyLeading: false,title: Text('Dashboard')),
//       body: Center(
//         child: Text('Dashboard Screen', style: TextStyle(fontSize: 40)),
//       )
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



import 'body.dart';
import 'constants.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Body(),
    );
  }

 
}
