import 'package:flutter/material.dart';
import 'package:swdproject/page/history.dart';
import 'package:swdproject/page/home/dashboard.dart';
import 'package:swdproject/page/loginsuccess.dart';
import 'package:swdproject/page/profile.dart';
import 'package:swdproject/page/setting.dart';
import 'package:swdproject/page/wallet_page.dart';

import 'models/person.dart';


class Home extends StatefulWidget {
  
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  int currentTab=0;
 
  final List<Widget> screens=[
    Dashboard(),
    History(),
    Profile(),
    Setting(),
    HomeScreen()
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Dashboard();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.wallet),
        onPressed: (){Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WalletPage()));},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked ,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                      onPressed: (){
                            setState(() {
                              currentScreen=Dashboard();
                              currentTab=0;
                            });
                      },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.dashboard,
                          color: currentTab==0 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Dashboard',
                          style: TextStyle(color: currentTab==0 ? Colors.blue : Colors.grey),

                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=History();
                        currentTab=1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_time_filled_sharp,
                          color: currentTab==1 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'History',
                          style: TextStyle(color: currentTab==1 ? Colors.blue : Colors.grey),

                        )
                      ],
                    ),
                  )
                ],
              ),
              // Right Tab bar icons
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=Profile();
                        currentTab=2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_box,
                          color: currentTab==2 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Profile',
                          style: TextStyle(color: currentTab==2 ? Colors.blue : Colors.grey),

                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: (){
                      setState(() {
                        currentScreen=Setting();
                        currentTab=3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          color: currentTab==3 ? Colors.blue : Colors.grey,
                        ),
                        Text(
                          'Setting',
                          style: TextStyle(color: currentTab==3 ? Colors.blue : Colors.grey),

                        )
                      ],
                    ),
                  )
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
