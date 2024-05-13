import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../LoginWidgets/login_text_form_field.dart';
import '../Pages/profile.dart';
import '../controller/storage.dart';
import 'calendar.dart';

class EditProfilePageWidget extends StatefulWidget {
  const EditProfilePageWidget({super.key, required this.title});
  final String title;

  @override
  State createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePageWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<Map<String, String>> _loadUserInfo() async {
    await Future.delayed(const Duration(seconds: 2));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name') ?? '';
    final String surname = prefs.getString('surname') ?? '';
    final String lastName = prefs.getString('lastName') ?? '';
    final String birthday = prefs.getString('birthday') ?? '';
    return {
      'name': name,
      'surname': surname,
      'lastName': lastName,
      'birthday': birthday,
    };
  }


  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;
    const appColor = Color.fromRGBO(9, 0, 171, 0.8);
    const textColorInverted = Color.fromRGBO(255, 255, 255, 1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor,
        title: const Text('Edit Profile', style: TextStyle(color: textColorInverted)),
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder<Map<String, String>>(
                future: _loadUserInfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final Map<String, String> userInfo = snapshot.data!;
                    return Column(
                      children: <Widget>[
                        SizedBox(
                          width: deviceWidth(context) / 2,
                          height: deviceHeight(context) * 0.1,
                          child: TextFormField(
                            controller: _nameController..text = userInfo['name']!,
                            decoration: InputDecoration(
                              hintText: "Enter your name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) / 2,
                          height: deviceHeight(context) * 0.1,
                          child: TextFormField(
                            controller: _surnameController..text = userInfo['surname']!,
                            decoration: InputDecoration(
                              hintText: "Enter your surname",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your surname';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) / 2,
                          height: deviceHeight(context) * 0.1,
                          child: TextFormField(
                            controller: _lastNameController..text = userInfo['lastName']!,
                            decoration: InputDecoration(
                              hintText: "Enter your last name",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your last name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth(context) / 2,
                          height: deviceHeight(context) * 0.1,
                          child: TextFormField(
                            controller: _birthdayController..text = userInfo['birthday']!,
                            decoration: InputDecoration(
                              hintText: "Enter your birthday",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your birthday';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: deviceHeight(context) * 0.04),
                        SizedBox(
                          width: deviceWidth(context) / 2,
                          height: deviceHeight(context) * 0.05,
                          child: ElevatedButton(
                            onPressed: () {
                              _saveProfileInfo();
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProfilePageWidget(title: "some title")),
                              );
                            },
                            child: const Text('Save Changes'),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfileInfo() async {
    final LocalStorage storage = SharedPreferencesStorage();
    await storage.saveData('name', _nameController.text);
    await storage.saveData('surname', _surnameController.text);
    await storage.saveData('lastName', _lastNameController.text);
    await storage.saveData('birthday', _birthdayController.text);
  }

}
