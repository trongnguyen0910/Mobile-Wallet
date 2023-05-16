import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdproject/page/wallet_page.dart';
import 'package:swdproject/themes/theme_model.dart';

import '../service/firebase_service.dart';
import 'login.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
    late String imageUrl = '';
    late String name = '';
 @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        imageUrl = prefs.getString('imageUrl') ?? '';
      });
    });
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('name') ?? '';
      });
    });
  }
  
    bool isDarkMode = false;
    
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder:(context, ThemeModel themeNotificer, child){
      return Scaffold(
          
        appBar: AppBar(
            automaticallyImplyLeading: false,
          title: Text(
            "Settings",
           
          ),
          
          centerTitle: true,
          
          elevation: 0,
          actions: [IconButton(
          onPressed:(){
             themeNotificer.isDark
                      ?themeNotificer.isDark=false
                      :themeNotificer.isDark=true;
          } 
          , icon: Icon(themeNotificer.isDark? Icons.wb_sunny: Icons.nightlight_round)),
          ],
          
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              // user card
              SimpleUserCard(
                userName: "${name}",
                 userProfilePic: NetworkImage(imageUrl.isNotEmpty
                        ? imageUrl
                        : FirebaseAuth.instance.currentUser!.photoURL!),
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WalletPage()));},
                    icons: CupertinoIcons.creditcard_fill,
                    iconStyle: IconStyle(),
                    title: 'Wallet',
                    
                  ),
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.fingerprint,
                    iconStyle: IconStyle(
                      iconsColor: Colors.white,
                      withBackground: true,
                      backgroundColor: Colors.red,
                    ),
                    title: 'Privacy',
                   
                  ),
                 
                ],
              ),
              SettingsGroup(
                items: [
                  SettingsItem(
                    onTap: () {},
                    icons: Icons.info_rounded,
                    iconStyle: IconStyle(
                      backgroundColor: Colors.purple,
                    ),
                    title: 'About',
                   
                  ),
                ],
              ),
              // You can add a settings title
              SettingsGroup(
                settingsGroupTitle: "Account",
                items: [
                  SettingsItem(
                    onTap: () async { await FirebaseServices().googleSignOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()));},
                    icons: Icons.exit_to_app_rounded,
                    title: "Sign Out",
                  ),
                  SettingsItem(
                    onTap: () async { await FirebaseServices().googleSignOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoginScreen()));},
                    icons: CupertinoIcons.repeat,
                    title: "Change email",
                  ),
                 
                ],
              ),
            ],
          ),
        ),
      );
      }
    );
  }
  
}
