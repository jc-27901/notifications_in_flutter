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

  List<String> ist = [];
  FlutterLocalNotificationsPlugin fltrNotification;
  Future<void> _show() async {
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
      if (pm == 'PM') {
        hour = hour + 12;
        print(hour);
      }
      ist.add(
        _selectedTime,
      );
      _showNotification(hour, min, DateTime.now());
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

  Future _showNotification(int hr, int min, DateTime fetchId) async {
    notify();

    int id = 0;

    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Jay", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    print('hello');
    print(hr);
    print(min);
    var scheduledTime;
    print('fetchId=');
    print(fetchId.second);
    print(DateTime.now().second);

    if (fetchId.minute == DateTime.now().minute) {
      id++;
      print(id);
    }

    var time = Time(hr, min, 0);

    // if (_selectedParam == 'Hour') {
    //   scheduledTime = time;
    // }
    // if (_selectedParam == 'Minutes') {
    //   scheduledTime = DateTime.now().add(Duration(minutes: val));
    // }
    // if (_selectedParam == 'Seconds') {
    //   scheduledTime = DateTime.now().add(Duration(seconds: val));
    // }

    fltrNotification.showDailyAtTime(id, 'Times upp',
        "I am $id first Notification", time, generalNotificationDetails);
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
        onPressed: _show,
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

class Demo {
  final Function fnc;
  final String date;

  Demo({this.date, this.fnc});
}
