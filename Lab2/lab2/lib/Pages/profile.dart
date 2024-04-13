import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import '../controller/storage.dart'; // Змінено імпорт для використання класів LocalStorage і SharedPreferencesStorage
import '../Pages/calendar.dart';
import '../Pages/login.dart';
import 'edit_page.dart';

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

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    final String? loggedInUsername = await _localStorage.getData('logged_in_username');
    if (loggedInUsername != null) {
      _username = loggedInUsername;
      _name = await _localStorage.getData('name') ?? 'Your Name';
    }
    setState(() {});
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPageWidget(title: "some title")),
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
