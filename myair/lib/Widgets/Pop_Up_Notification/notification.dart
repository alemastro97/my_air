import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initNotifications() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async{});
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<void> pushNotification() async {

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'push_messages: 0',
      'push_messages: push_messages',
      'push_messages: A new Flutter project',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
      enableVibration: true,
      playSound: true,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
     // sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    final List<ActiveNotification> activeNotifications =
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    bool launched = false;
    activeNotifications.forEach((element) {if(element.channelId == 'push_messages: 0') launched = true;});
  if(!launched) {
      await flutterLocalNotificationsPlugin.show(0, 'MyAir',
          'You have entered a polluted area', platformChannelSpecifics,
          payload: 'item x');
  }
  }


  Future<void> pushNotificationReward() async {
    print("Notifiaaaaaaaa");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'push_messages: 1',
      'push_messages: push_messages',
      'push_messages: A new Flutter project',
      importance: Importance.low,
      priority: Priority.low,
      showWhen: false,
      enableVibration: true,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),

    );
    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
      // sound: 'a_long_cold_sting.wav',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);
    final List<ActiveNotification> activeNotifications =
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    bool launched = false;
    activeNotifications.forEach((element) {if(element.channelId == 'push_messages: 1') launched = true;});
    if(!launched) {   await flutterLocalNotificationsPlugin.show(1, 'MyAir',
          'You have completed a challenge', platformChannelSpecifics,
          payload: 'item x');
   }
  }



  Future selectNotification(String payload) async {
    // some action...
  }
}