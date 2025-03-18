/*
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {


  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _messageStreamController = BehaviorSubject<RemoteMessage>();


  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }




  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService._internal();

  Future<void> initNotification() async {

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );

    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }
      _messageStreamController.sink.add(message);
    });

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotifications);
  }

  void onSelectNotifications(String? payload) {

    print("svfsdgwegweg${payload}");

  }





  Future<void> showNotification(String notificationId, int id, String title,
      String body, int time) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, time),
      //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 1)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            'reminder_channel', 'Reminder Channel',
            channelDescription: "set Reminder notification",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true),
        // iOS details
        iOS: IOSNotificationDetails(
          sound: 'default.wav',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),

      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: notificationId,
    );
  }
}
*/

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:iroots/src/ui/dashboard/dashboard_screen.dart';
import 'package:rxdart/rxdart.dart';

class NotificationService {
  /*static int _notificationCount = 0;
  static final StreamController<int> _notificationCountController = StreamController<int>();
  static Stream<int> get notificationCountStream => _notificationCountController.stream;*/

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    final messageStreamController = BehaviorSubject<RemoteMessage>();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    // final IOSInitializationSettings initializationSettingsIOS =
    //     IOSInitializationSettings(
    //   onDidReceiveLocalNotification:
    //       (int id, String? title, String? body, String? payload) async {},
    // );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
    );

    // await FirebaseMessaging.instance.subscribeToTopic('your_topic'); // optional: subscribe to a topic
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      sound: true,
      alert: true,
      badge: true,
    );
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: (String? payload) async {
      //   if (payload != null) {
      //     clearNotificationCount();
      //     _handleNotificationClick(payload);
      //   }
      // },
    );

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data['key_1']}');
        print('Message notification: ${message.notification?.body}');
        print('Message notification: ${message.notification?.body}');
        print('Message notification: ${message.data['title']}');
        print('Message notification: ${message.data['body']}');
        /*_notificationCount++;
        _notificationCountController.sink.add(_notificationCount);*/
      }

      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
              'nirmala_convent_channel', 'Nirmal Convent Channel',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              playSound: true);

      /*FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        _handleNotificationClick(message);
      });*/

      NotificationDetails platformChannelSpecifics =
          const NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.show(
        0,
        message.notification?.title ?? 'Notification Title',
        message.notification?.body ?? 'Notification Body',
        platformChannelSpecifics,
        payload: message.data['key_1'] ?? '',
      );
      messageStreamController.sink.add(message);
    });
  }

  static void clearNotificationCount() {
    /*  _notificationCount = 0;
    _notificationCountController.add(0);*/
  }

  void _handleNotificationClick(String payload) {
    print("sagwsgwgg: $payload");

    Get.to(() => const DashBoardPageScreen());
    //Get.toNamed('/dashboard', arguments: payload);
  }

/*  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");
  }*/
}
