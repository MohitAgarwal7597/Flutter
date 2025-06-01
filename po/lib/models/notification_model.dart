import 'package:hive/hive.dart';

part 'notification_model.g.dart'; // Run build_runner after this

@HiveType(typeId: 1)
class LocalNotificationModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  DateTime date;

  LocalNotificationModel({
    required this.title,
    required this.body,
    required this.date,
  });
}
