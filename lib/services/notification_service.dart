import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

// Global instance of the plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

int _notificationIdCounter = 0;

// Function to get a unique ID
int _generateUniqueId() {
  // A simple incrementing counter is sufficient for this example.
  // In a more complex app, you might need a more robust ID generation strategy
  // if you expect very large numbers of notifications or specific persistence needs.
  _notificationIdCounter++;
  return _notificationIdCounter;
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
}

class NotificationService {
  Future<void> initializeNotifications() async {
    // Android settings
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS settings
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        );

    // Initialization settings for both platforms
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
        );

    // Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        // Handle tapping on a notification (background/terminated/foreground)
        // This callback is triggered by user interaction (tapping the body or an action).
        {
          // Check if the user tapped the notification body
          if (notificationResponse.notificationResponseType ==
              NotificationResponseType.selectedNotification) {
            // This block handles taps on the notification body.
            debugPrint(
              'Notification tapped (selected): ${notificationResponse.payload}',
            );
            // For this app, we don't need specific navigation on tap, but you could add it here.
          } else if (notificationResponse.notificationResponseType ==
              NotificationResponseType.selectedNotificationAction) {
            // This block handles taps on notification action buttons (if you add them).
            debugPrint(
              'Notification action tapped: ${notificationResponse.actionId}',
            );
          }
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    // Request permissions for Android 13+ and iOS
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<int> scheduleNotification({
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    String? payload,
  }) async {
    final int id = _generateUniqueId(); // Get a unique ID for this notification

    const AndroidNotificationDetails
    androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'pomodoro_timer_channel_id', // Channel ID (needs to be consistent)
      'Pomodoro Timer Notifications', // Channel name shown to the user
      channelDescription:
          'Notifications for completed Pomodoro sessions', // Channel description
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails();

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id, // Unique ID for the notification
      title,
      body,
      scheduledDate, // The exact time to show the notification
      platformChannelSpecifics,
      androidScheduleMode:
          AndroidScheduleMode
              .exactAllowWhileIdle, // Use exact mode for precision
      payload: payload,
      matchDateTimeComponents:
          DateTimeComponents
              .time, // Optional: Match only time for recurring notifications (not needed for single event)
    );

    debugPrint('Scheduled notification with ID: $id for $scheduledDate');
    return id; // Return the ID so the TimerProvider can keep track of it
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    debugPrint('Cancelled notification with ID: $id');
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
    debugPrint('Cancelled all pending notifications');
  }
}
