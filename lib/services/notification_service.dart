import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Global instance of the plugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// Define a top-level function for the notification tap action (required by plugin)
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // handle action
  // This function will be executed in the background on Android when a notification is tapped.
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

  // Add methods here later for scheduling notifications, cancelling notifications, etc.
}
