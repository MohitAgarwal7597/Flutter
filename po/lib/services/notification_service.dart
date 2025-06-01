// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
// import 'package:po/routes/app_router.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:po/app/app_imports/app_imports.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'maturity_channel', // Channel ID
    'Maturity Notifications',
    description: 'Channel for account maturity reminders',
    importance: Importance.high,
  );

  static Future<void> initialize() async {
    // Timezone for scheduling
    tz.initializeTimeZones();
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
    );

    await _plugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payload = response.payload;
      if (payload == 'open_notifications') {
        AppRouter.router.push('/notifications');
      }
    });

    // Create Android channel
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);
  }

  static Future<void> requestNotificationPermission() async {
    final plugin = FlutterLocalNotificationsPlugin();
    final androidImplementation = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final bool? granted =
        await androidImplementation?.requestNotificationsPermission();
    print('Notification permission granted: $granted');
  }
  // use this only when you want to test notification

  // static Future<void> showTestNotification() async {
  //   await _plugin.show(
  //     9999,
  //     'Test Notification',
  //     'This is a test notification!',
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'maturity_channel',
  //         'Maturity Notifications',
  //         channelDescription: 'Used for account maturity reminders',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //       ),
  //       iOS: DarwinNotificationDetails(),
  //     ),
  //   );
  // }
  static Future<void> scheduleMaturityNotificationTwo({
    required int id,
    required String title,
    required String body,
    required DateTime maturityDate,
    required String schemeType,
    required String accountNumber,
    required String name,
    required String amount,
  }) async {
    // final scheduledDate = DateTime.now().add(Duration(seconds: 10));
    final scheduledDate = maturityDate.subtract(Duration(days: 3));

    // print("Notification scheduled for: $scheduledDate");

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'maturity_channel',
          'Maturity Notifications',
          channelDescription: 'Used for account maturity reminders',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            'Your $schemeType with number $accountNumber is maturing on '
            '${DateFormat('dd MMM yyyy').format(maturityDate)}.\n'
            'Account Holder: $name\n\nDenomination: $amount',
            contentTitle: 'Account Maturity Alert',
            summaryText: 'Tap to view full details',
          ),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: 'open_notifications',
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // Use this only if you want it to repeat every day at same time:
      // matchDateTimeComponents: DateTimeComponents.time,
    );
  }
  static Future<void> scheduleMaturityNotificationThree({
    required int id,
    required String title,
    required String body,
    required DateTime maturityDate,
    required String schemeType,
    required String accountNumber,
    required String name,
    required String amount,
  }) async {
    // final scheduledDate = DateTime.now().add(Duration(seconds: 10));
    final scheduledDate = maturityDate.subtract(Duration(days: 1));

    // print("Notification scheduled for: $scheduledDate");

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'maturity_channel',
          'Maturity Notifications',
          channelDescription: 'Used for account maturity reminders',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            'Your $schemeType with number $accountNumber is maturing on '
            '${DateFormat('dd MMM yyyy').format(maturityDate)}.\n'
            'Account Holder: $name\n\nDenomination: $amount',
            contentTitle: 'Account Maturity Alert',
            summaryText: 'Tap to view full details',
          ),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: 'open_notifications',
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // Use this only if you want it to repeat every day at same time:
      // matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleMaturityNotification({
    required int id,
    required String title,
    required String body,
    required DateTime maturityDate,
    required String schemeType,
    required String accountNumber,
    required String name,
    required String amount,
  }) async {
    // final scheduledDate = DateTime.now().add(Duration(seconds: 10));
    final scheduledDate = maturityDate.subtract(Duration(days: 7));

    // print("Notification scheduled for: $scheduledDate");

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      NotificationDetails(
        android: AndroidNotificationDetails(
          'maturity_channel',
          'Maturity Notifications',
          channelDescription: 'Used for account maturity reminders',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            'Your $schemeType with number $accountNumber is maturing on '
            '${DateFormat('dd MMM yyyy').format(maturityDate)}.\n'
            'Account Holder: $name\n\nDenomination: $amount',
            contentTitle: 'Account Maturity Alert',
            summaryText: 'Tap to view full details',
          ),
        ),
        iOS: DarwinNotificationDetails(),
      ),
      payload: 'open_notifications',
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      // Use this only if you want it to repeat every day at same time:
      // matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
