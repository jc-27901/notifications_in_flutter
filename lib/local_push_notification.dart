import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications_in_flutter/not_usefull.dart';

class SendNotificationScreen extends StatefulWidget {
  static const routeName = 'send-notification-screen';

  @override
  _SendNotificationScreenState createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  FlutterLocalNotificationsPlugin fltrNotification;

  @override
  void initState() {
    super.initState();
  }

  void notify() {
    var androidInitilize = new AndroidInitializationSettings('a');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings = new InitializationSettings(
        android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = new FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected);
  }

  Future _showNotification() async {
    notify();

    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Jay", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    print('hello');

    //time to show first notification
    var time = Time(11, 58, 0);

    // ignore: deprecated_member_use
    fltrNotification.showDailyAtTime(1, 'Times upp', "I am first Notification",
        time, generalNotificationDetails);
  }

  Future _showNotification1() async {
    notify();

    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Jay", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    print('hello1');

//time to show first notification
    var time = Time(12, 20, 0);

    // ignore: deprecated_member_use
    fltrNotification.showDailyAtTime(4, 'Second Notification',
        "I am second notification", time, generalNotificationDetails);
  }

  Future _showNotification2() async {
    notify();
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Jay", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    print('hello2');

//time to show first notification
    var time = Time(12, 45, 0);

    // ignore: deprecated_member_use
    fltrNotification.showDailyAtTime(7, 'Third Notification',
        "I am third notification", time, generalNotificationDetails);
  }

  String task;

  int val;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: GestureDetector(
                onTap: (() {
                  _showNotification();
                  _showNotification1();
                  _showNotification2();
                }),
                child: Container(
                  height: 280,
                  width: 280,
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      'Send Notification',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Click this button to send a \n basic notification',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async {
    showDialog(
      context: context,
      builder: (context) => NotuseFull(),
    );
  }
}
