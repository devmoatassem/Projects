import 'package:aeye/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Some high level definations to initiate background and FCM notification
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
      'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print('A bg message just showed up :  ${message.messageId}');
}



//main function 

Future<void> main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Request storage permission
  //await Permission.storage.request();

  // Set the persistence option to LOCAL
  // await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);


//Code for notification part

FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

//necessary to receive message from python code  to subscribe to a topic
  FirebaseMessaging.instance.subscribeToTopic('test01'); 


  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



@override
void initState() {
  
    super.initState();


    var initialzationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Color(0xFFFE8116),
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      //print('A new onMessageOpenedApp event was published!');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });


  }
  

  // var auth = FirebaseAuth.instance;
  // var isLogin = false;

  // checkifLogin() async {
  //   auth.authStateChanges().listen((User? user) {
  //     if (user != null && mounted) {
  //       setState(() {
  //         isLogin = true;
  //       });
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   _requestPermission();
  //   checkifLogin();

  //   super.initState();
  //   // Timer(
  //   //   const Duration(seconds: 2),
  //   //   () {
  //   //     Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>isLogin ? const ModeChose() : const OnboardingScreen(),));
  //   //   },
  //   // );
  // }

  @override
  Widget build(BuildContext context) {
   return const MaterialApp(
     //title: 'Flutter Onboarding UI',
      debugShowCheckedModeBanner: false,
      home: 
      SplashScreen(),
      //isLogin ? const ModeChose() : const OnboardingScreen(),
     );
  }

  // _requestPermission() async {
  //   var status = await Permission.location.request();
  //   if (status.isGranted) {
  //     //print('done');
  //   } else if (status.isDenied) {
  //     _requestPermission();
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }
}
