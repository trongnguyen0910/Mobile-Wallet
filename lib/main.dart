
import 'dart:convert';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swdproject/page/login.dart';
import 'package:swdproject/pushnoti/empty_page.dart';
import 'package:swdproject/pushnoti/home_noti.dart';
import 'package:swdproject/pushnoti/notification_provider.dart';
import 'package:swdproject/service/firebaseconfig.dart';
import 'package:swdproject/themes/theme_model.dart';

import 'home.dart';

PushNotificationsProvider pushNotificationsProvider =
PushNotificationsProvider();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call initializeApp before using other Firebase services.
  print('Recibiendo notificacion en segundo plano ${message.messageId}');
  // pushNotificationsProvider.showNotification(message);
}

Future<void> initializeFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase and wait for it to complete
  await Firebase.initializeApp(
    name: 'wallet-fpt',
    options: FirebaseConfig.currentPlatform,
  );

  // Get the Firebase Messaging token and write it to storage
  final token = await FirebaseMessaging.instance.getToken();
  // if (token != null) {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('token', token);
  // }
  print('getToken: $token');

  // Set the onBackgroundMessage handler and initialize push notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
 
  messaging.requestPermission();
  FirebaseMessaging.instance.subscribeToTopic('my-topic');

  messaging.getToken().then((token) async {
    
    print("Token: $token");
     SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString('token', token!);
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Received message: $message");
    
  });

// If application is in Background
  FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        print("onMessageOpenApp: $message");
       Navigator.push(
       navigatorKey.currentState!.context,
        MaterialPageRoute(
         builder: (context) => HomeNoti(message: json.encode(message.data)),
    ),
        );
      },
  );


// If app is closed
  FirebaseMessaging.instance.getInitialMessage().then(
        (RemoteMessage? message) {
     if(message != null){
          Navigator.push(
      navigatorKey.currentState!.context,
      MaterialPageRoute(
        builder: (context) => HomeNoti(message: json.encode(message.data)),
      ),
    );
     }
    },
  );

  
  runApp(const MyApp());

}




class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState(){
     super.initState();
    pushNotificationsProvider.onMessageListener(context as BuildContext);
  }

  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer(
        builder: (context, ThemeModel themeNotificer, child){
          return MaterialApp(
      title: 'Footer Menu',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // home: Home(),
      theme: themeNotificer.isDark ? ThemeData.dark():ThemeData.light(),
      home: const LoginScreen(),
      );
      },
      )
      // home: const ImageUploaderWidget(),
      // home: const EmptyPage(),
      // navigatorKey: navigatorKey,
      // routes: {
      //   '/':((context)=>const EmptyPage()),
      //   '/push-page': ((context)=>const HomeNoti()),
      // },
      // debugShowCheckedModeBanner: false,
    );
  } 
}

