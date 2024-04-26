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

  Future<void> _loadUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('name') ?? '';
      _surnameController.text = prefs.getString('surname') ?? '';
      _lastNameController.text = prefs.getString('lastName') ?? '';
      _birthdayController.text = prefs.getString('birthday') ?? '';
    });
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
              child: Column(
                children: <Widget>[
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _nameController, hintText: "Enter your name", validationName: "Name"),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _surnameController, hintText: "Enter your surname", validationName: "Name"),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _lastNameController, hintText: "Enter your last name", validationName: "Name"),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _birthdayController, hintText: "Enter your birthday", validationName: "Date"),
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
