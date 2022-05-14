import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  FirebaseMessaging firebaseMessaging;

  NotificationService({required this.firebaseMessaging});

  Future<NotificationSettings> setupNotification() async {
    NotificationSettings notificationSettings =
        await firebaseMessaging.requestPermission(
            alert: true,
            announcement: true,
            badge: true,
            carPlay: false,
            criticalAlert: true,
            provisional: false,
            sound: true);

    return notificationSettings;
  }
}
