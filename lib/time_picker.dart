import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'not_usefull.dart';

class TimePicker extends StatefulWidget {
  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  String _selectedTime;
  int id = 0;
  List<String> ist = [];
  FlutterLocalNotificationsPlugin fltrNotification;
  Future<void> _show(int id) async {
    final TimeOfDay result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
      print(_selectedTime);
      String h = _selectedTime.substring(0, 2);
      int hour = int.parse(h);
      //  print(hour);

      String m = _selectedTime.substring(3, 5);

      int min = int.parse(m);
      // print(min);
      String pm = _selectedTime.substring(6);
      print(pm);
      print(id);
      if (pm == 'PM') {
        hour = hour + 12;
        print(hour);
      }
      ist.add(
        _selectedTime,
      );

      _showNotification(hour, min, id);
    }
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

  Future _showNotification(int hr, int min, int id) async {
    notify();

    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Jay", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    print('hello');
    print(hr);
    print(min);

    print('fetchId=');

    print(id);
    var time = Time(00, min, 0);

    // ignore: deprecated_member_use
    fltrNotification.showDailyAtTime(id, 'Times upp',
        "I am  $id  first Notification", time, generalNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          _selectedTime != null ? ist.toString() : 'No time Selected!',
          style: TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          id = id + 1;

          _show(id);
        },
        child: Text('Timepicker'),
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
