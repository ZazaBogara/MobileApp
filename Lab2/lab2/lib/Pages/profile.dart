import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import '../controller/storage.dart';
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

class ProfilePageWidget extends StatelessWidget {
  const ProfilePageWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return ProfilePageView(title: title);
  }
}

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final LocalStorage _localStorage = SharedPreferencesStorage();
  late String _username = "YourUsername";
  late String _name = "YourName";
  String appBarTitle = 'Your Planner';
  late Future<void> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _getUserInfo();
    _setAppBarTitle();
  }

  Future<void> _getUserInfo() async {
    final String? loggedInUsername = await _localStorage.getData('logged_in_username');
    final String? name = await _localStorage.getData('name');
    setState(() {
      _username = loggedInUsername ?? 'YourUsername';
      _name = name ?? 'Your Name';
    });
  }

  Future<void> _setAppBarTitle() async {
    final hasInternet = await checkInternetConnection();
    setState(() {
      appBarTitle = hasInternet ? 'Your Planner' : 'No Internet';
    });
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
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
                      const CircleAvatar(
                        radius: 40.0,
                        //backgroundImage: AssetImage('./assets/default_profile_image.jpg'),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Login: $_username',
                        style: const TextStyle(fontSize: 13.0),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Name: $_name',
                        style: const TextStyle(fontSize: 13.0),
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
