import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_notifications_app/domain/entities/push_message.dart';
import 'package:push_notifications_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {

  final String pushMessageId;

  // Constructor
  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {

    final PushMessage? notification = context.watch<NotificationsBloc>()
      .getNotificationById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Push'),
      ),
      body: notification != null
        ? _DetailsView(notification: notification)
        : const Center(
          child: Text('There are no notifications'),
        ),
    );
  }
}

class _DetailsView extends StatelessWidget {

  final PushMessage notification;

  const _DetailsView({ required this.notification });

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [

          if (notification.imageUrl != null)
            Image.network(notification.imageUrl!),

          const SizedBox(height: 30),

          Text(notification.title, style: textStyles.titleMedium),
          Text(notification.body),

          const Divider(),

          Text(notification.data.toString()),

        ],
      ),
    );
  }
}
