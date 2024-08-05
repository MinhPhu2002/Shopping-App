import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:testapp/module/service/local_notification_controller.dart';

class NotificationService {
  NotificationService._privateConstructor();
  static final NotificationService _instance =
      NotificationService._privateConstructor();
  static NotificationService get instance => _instance;
  void initialize() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("FCM Token: $token");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      final notification = message.notification;
      if (notification != null) {
        print('Message also contained a notification: ${message.notification}');
        LocalNotificationController().showNotification(
            title: notification.title.toString(),
            text: notification.body.toString());
        // Show notification or use a method to display it in your UI
      }
    });
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
}
