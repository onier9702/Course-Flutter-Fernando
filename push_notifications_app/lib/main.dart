import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:go_router/go_router.dart';

import 'package:push_notifications_app/config/router/app_router.dart';
import 'package:push_notifications_app/config/theme/app_theme.dart';

import 'package:push_notifications_app/presentation/blocs/notifications/notifications_bloc.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  // Init at top level of the app the onBackground message notification
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await NotificationsBloc.initializeFCM();

  runApp(
    // HERE we are setting the block provider in the highest point of the app
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NotificationsBloc())
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      builder: (context, child) => HandleNotificationInteractions(child: child!),

      // Not needed after make router
      // home: const Scaffold(
      //   body: Center(
      //     child: Text('Hello World!'),
      //   ),
      // ),
    );
  }
}

// To allow open notifications when app is closed that user 
// click over the badge notifcations and that open the app and for that reason this class
class HandleNotificationInteractions extends StatefulWidget {

  final Widget child;

  const HandleNotificationInteractions({super.key, required this.child});

  @override
  State<HandleNotificationInteractions> createState() => _HandleNotificationInteractionsState();
}

class _HandleNotificationInteractionsState extends State<HandleNotificationInteractions> {

  // It is assumed that all messages contain a data field with the key 'type'
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }
  
  void _handleMessage(RemoteMessage message) {

    context.read<NotificationsBloc>().handleRemoteMessage(message);

    // on this point maybe we do not have the context because is so fast that can fails
    // context.push('/push-notification-details/${message.messageId}');

    // For that reason use the function appRouter directly
    final messageId = message.messageId?.replaceAll(':', '').replaceAll('%', '');
    appRouter.push('/push-notification-details/$messageId');

    // if (message.data['type'] == 'chat') {
    //   Navigator.pushNamed(context, '/chat', 
    //     arguments: ChatArguments(message),
    //   );
    // }
  }

  @override
  void initState() {
    super.initState();

    // Run code required to handle interacted messages in an async function
    // as initState() must not be async
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {

    return widget.child;
  }
}
