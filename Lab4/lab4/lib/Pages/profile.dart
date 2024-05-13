import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import '../controller/storage.dart'; // Змінено імпорт для використання класів LocalStorage і SharedPreferencesStorage
import '../Pages/calendar.dart';
import '../Pages/login.dart';
import 'edit_page.dart';

AlertDialog _showNoInternetAlertDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('No Internet Connection'),
    content: const Text('Please check your internet connection and try again.'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Close the dialog
        },
        child: const Text('OK'),
      ),
    ],
  );
}


class ProfilePageWidget extends StatefulWidget {
  const ProfilePageWidget({super.key, required this.title});
  final String title;

  @override
  State createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageWidget> {
  final LocalStorage _localStorage = SharedPreferencesStorage(); // Використання класу SharedPreferencesStorage для роботи з локальним сховищем
  String _username = 'YourUsername';
  String _name = 'Your Name';
  String appBarTitle = 'Your Planner';
  late Future<Map<String, String>> _userDataFuture;



  Future<Map<String, String>> _getUserInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    final String? loggedInUsername = await _localStorage.getData('logged_in_username');
    final String? name = await _localStorage.getData('name');
    return {
      'username': loggedInUsername ?? 'YourUsername',
      'name': name ?? 'Your Name',
    };
  }

  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserInfo();
    _setAppBarTitle();
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _setAppBarTitle() async {
    final hasInternet = await checkInternetConnection();
    setState(() {
      appBarTitle = hasInternet ? 'Your Planner' : 'No Internet';
      print("internet");
      if (!hasInternet) {
        print("no internet");
        _showNoInternetAlertDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const appColor = Color.fromRGBO(9, 0, 171, 0.8);
    const textColorInverted = Color.fromRGBO(255, 255, 255, 1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor,
        title: Text(appBarTitle, style: TextStyle(color: textColorInverted)),
      ),
      body: FooterView(
        footer: Footer(
          backgroundColor: appColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.event_note, color: Colors.white),
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
                icon: const Icon(Icons.person, color: Colors.grey),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePageWidget(title: "some title")),
                  );
                },
              ),
            ],
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FutureBuilder<Map<String, String>>(
                        future: _userDataFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            final username = snapshot.data?['username'] ?? 'YourUsername';
                            final name = snapshot.data?['name'] ?? 'Your Name';

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const CircleAvatar(
                                  radius: 40.0,
                                  //backgroundImage: AssetImage('./assets/default_profile_image.jpg'),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  'Login: $username',
                                  style: const TextStyle(fontSize: 13.0),
                                ),
                                const SizedBox(height: 10.0),
                                Text(
                                  'Name: $name',
                                  style: const TextStyle(fontSize: 13.0),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality
                  },
                  child: const Text('Change Profile Picture'),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Change password functionality
                  },
                  child: const Text('Change Password'),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditProfilePageWidget(title: "some title")),
                    );
                  },
                  child: const Text('Change Personal Info'),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Show confirmation dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Logout'),
                          content: Text('Are you sure you want to log out?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () async {
                                // Delete the logged_in_username
                                await _localStorage.deleteData('logged_in_username');
                                // Navigate back to the login page
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const LoginPageWidget(title: "some title")),
                                      (Route<dynamic> route) => false, // Remove all routes until the new one
                                );
                              },
                              child: Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Logout'),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
