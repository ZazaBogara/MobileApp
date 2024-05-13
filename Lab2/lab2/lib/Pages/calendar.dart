import 'dart:io';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:lab2/CalendarWidgets/planner_header.dart';
import 'package:lab2/CalendarWidgets/planner_table.dart';
import 'package:lab2/Pages/profile.dart';
import 'package:flash_light_control_plugin/flash_light_control_plugin.dart'; // Import the flashlight plugin

class CalendarPageWidget extends StatefulWidget {
  const CalendarPageWidget({super.key, required this.title});
  final String title;
  @override
  State createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPageWidget> {

  void _showIOSNotification() {
    if (Platform.isIOS) {
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notice'),
            content: const Text('YOU IOS, NO FLASHLIGHT'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const appColor = Color.fromRGBO(9, 0, 171, 0.8);
    const textColorInverted = Color.fromRGBO(255, 255, 255, 1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor,
        title: const Text('Your Planner', style: TextStyle(color: textColorInverted)),
      ),
      body: FooterView(
        footer: Footer(
          backgroundColor: appColor,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.event_note, color: Colors.grey),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CalendarPageWidget(title: "some title")),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.playlist_add_check, color: Colors.white),
                    onPressed: () {
                      // Add functionality
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ProfilePageWidget(title: "some title")),
                      );
                    },
                  ),
                ],
              ),
              // Adding the Row with ElevatedButtons here

            ],
          ),
        ),
        children: <Widget>[
          const PlannerHeader(),
          const PlannerTable(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (Platform.isIOS) {
                    _showIOSNotification();
                  } else {
                    FlashLightControlPlugin.turnOn(); // Call turnOn method from flashlight plugin
                  }
                },
                child: Text('Flashlight On'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Platform.isIOS) {
                    _showIOSNotification();
                  } else {
                    FlashLightControlPlugin.turnOff(); // Call turnOn method from flashlight plugin
                  }
                },
                child: Text('Flashlight Off'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
