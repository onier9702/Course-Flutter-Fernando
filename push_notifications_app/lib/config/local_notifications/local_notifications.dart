
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:push_notifications_app/config/router/app_router.dart';

// https://pub.dev/packages/flutter_local_notifications#-android-setup


class LocalNotifications {

  static Future<void> requestPermissionLocalNotifications() async {

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: iosShowLocalNotifications
    );

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // local notification appears on top of screen and user click it
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse 
    );
  }

  // method to call showLocalNotifications by positionated arguments and not by name
  static void iosShowLocalNotifications(
    int id,
    String? title,
    String? body,
    String? data
  ) {
    showLocalNotification(id: id, title: title, body: body, data: data);
  }

  static void showLocalNotification({
    required int id,
    String? title,
    String? body,
    String? data,
  }) {
    const androidDetails = AndroidNotificationDetails(
      'channelId',
      'channelName',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('custom_sound'),
      importance: Importance.max,
      priority: Priority.high
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentSound: true,
      ),
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: data
    );
  }

  // When user click over the local received notification
  static void onDidReceiveNotificationResponse(NotificationResponse response) {
    appRouter.push('/push-notification-details/${response.payload}');
  }
}
