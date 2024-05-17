import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:saasakitech_second_round_assignment/main.dart';

class FireBaseLogout{
  void logOut() async {
    await FirebaseAuth.instance.signOut();
  }

}

class FlutterNotification {
  Future<void> scheduleNotification(DateTime scheduledDate, String title, String body) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('your_channel_id', 'your_channel_name',
          channelDescription: 'your_channel_description',
          importance: Importance.max,
          priority: Priority.high,
          showWhen: false);
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // await flutterLocalNotificationsPlugin.schedule(
  //     0,
  //     title,
  //     body,
  //     scheduledDate,
  //     platformChannelSpecifics,
  //     androidAllowWhileIdle: true);
}
}