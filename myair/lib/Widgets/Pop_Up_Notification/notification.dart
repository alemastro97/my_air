import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//Class that manages the notification about the rewards and the warnings
class Notifications {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  //Initialization of the notification
  void initNotifications() async {

    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon'); // Chooses the app icon as icon to display when the notification arrives

    final IOSInitializationSettings initializationSettingsIOS = //Request all the permissions in iOS
    IOSInitializationSettings(
        requestAlertPermission: true,
        requestSoundPermission: true,
        requestBadgePermission: true,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async{});
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();

    //Set as the initialization settings the ones above
    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  //Notification of the pollution of the area
  Future<void> pushNotification() async {
    //Method that launch the notification with all its parameters
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'push_messages: 0',     //Channel of the notification
      'push_messages: push_messages', //Message of the notification
      'push_messages: A new Flutter project',
      importance: Importance.max,
      priority: Priority.high, //Priority use to show the notification
      showWhen: false,
      enableVibration: true,
      playSound: true,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'),
    );

    const iOSPlatformChannelSpecifics = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    //Generation of the channel
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics,iOS: iOSPlatformChannelSpecifics);

    final List<ActiveNotification> activeNotifications =
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.getActiveNotifications();
    bool launched = false;
    //Check that there are not other notification in the channel in order to not fill the channel with the same notification
    activeNotifications.forEach((element) {
      if(element.channelId == 'push_messages: 0') launched = true;
    }
    );
    if(!launched) {
      //In case there are not fired notification i launch one
      await flutterLocalNotificationsPlugin.show(0, 'MyAir',
          'You have entered a polluted area', platformChannelSpecifics,
          payload: 'item x');
    }
  }

//Notification about the completion of a reward
  Future<void> pushNotificationReward() async {

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