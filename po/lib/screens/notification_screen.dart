// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
// import 'package:po/models/notification_model.dart';
// import '../models/local_notification_model.dart';
import 'package:po/app/app_imports/app_imports.dart';
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Box<LocalNotificationModel> notificationBox =
        Hive.box<LocalNotificationModel>('notifications');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete All Notifications?'),
                  content: const Text(
                      'Are you sure you want to delete all notifications? This action cannot be undone.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        notificationBox.clear();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Delete',
                          style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: notificationBox.listenable(),
        builder: (context, Box<LocalNotificationModel> box, _) {
          final notifications = box.values.toList().reversed.toList();

          if (notifications.isEmpty) {
            return const Center(
              child: Text(
                'No notifications yet.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final n = notifications[index];
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  title: Text(n.title,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text(n.body),
                      const SizedBox(height: 6),
                      Text(
                        'Received on ${DateFormat('dd MMM yyyy, hh:mm a').format(n.date)}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Notification'),
                          content: const Text(
                              'Are you sure you want to delete this notification?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                final key = box.keyAt(box.length -
                                    1 -
                                    index); // Because you reversed the list
                                box.delete(key);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Delete',
                                  style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
