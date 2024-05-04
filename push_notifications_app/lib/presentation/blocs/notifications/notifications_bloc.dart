import 'dart:io'; // to use Platform on this case

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:push_notifications_app/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:push_notifications_app/domain/entities/push_message.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

// FOR Handling notifications on background app mode
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // constructor
  NotificationsBloc() : super(const NotificationsState()) {

    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_pushNotificationReceived);

    // Determined at the beggining which status we have
    _initialStatusCheck();
  }

  // FCM (Firebase Cloud Messaging)
  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }

  void _notificationStatusChanged(
    NotificationStatusChanged event,
    Emitter<NotificationsState> emit
  ) {
    emit(state.copyWith(
      status: event.status
    ));

    // Call to print token
    _getFCMToken();

    // Listen foreground notifications
    _onForegroundMessage();
  }

  void _pushNotificationReceived(
    NotificationReceived event,
    Emitter<NotificationsState> emit
  ) {
    emit(state.copyWith(
      notifications: [...state.notifications, event.notification],
    ));
  }

  void _initialStatusCheck() async {
    // instance of firebase messaging
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    final settings = await messaging.getNotificationSettings();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) return;

    // In your backend you can store the token te be able to send notifications to that device
    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');

    if (message.notification == null) return;

    final notification = PushMessage(
      messageId: message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
      title: message.notification!.title ?? '',
      body: message.notification!.body ?? '',
      sentDate: message.sentTime ?? DateTime.now(),
      data: message.data,
      imageUrl: Platform.isAndroid
        ? message.notification!.android?.imageUrl
        : message.notification!.apple?.imageUrl,
    );

    print(notification);
    // Trigger a new state calling the listener
    add(NotificationReceived(notification));
  }

  // Listener for listen foreground notifications
  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    // Save on state the status of authorization
    add(NotificationStatusChanged(settings.authorizationStatus));
    
  }

  // Method to return a notification by id
  PushMessage? getNotificationById(String id) {
    final exists = state.notifications.any((msg) => msg.messageId == id);

    if (!exists) return null;

    return state.notifications.firstWhere((msg) => msg.messageId == id);
  }
}
