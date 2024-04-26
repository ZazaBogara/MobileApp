import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import '../LoginWidgets/login_text_form_field.dart';
import '../Pages/login.dart';
import '../controller/storage.dart'; // Змінено імпорт для використання класів LocalStorage і SharedPreferencesStorage

class RegistrationPageWidget extends StatefulWidget {
  const RegistrationPageWidget({super.key, required this.title});
  final String title;

  @override
  State createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPageWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  final LocalStorage _localStorage = SharedPreferencesStorage(); // Використання класу SharedPreferencesStorage для збереження даних

  Future<void> _saveRegistrationData() async {
    await _localStorage.saveData('username', _usernameController.text);
    await _localStorage.saveData('password', _passwordController.text);
    await _localStorage.saveData('name', _nameController.text);
    await _localStorage.saveData('surname', _surnameController.text);
    await _localStorage.saveData('lastName', _lastNameController.text);
    await _localStorage.saveData('birthday', _birthdayController.text);
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
        title: const Text('Registration', style: TextStyle(color: textColorInverted)),
      ),
      body: FooterView(
        footer: Footer(
          backgroundColor: appColor,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: deviceHeight(context) * 0.03,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPageWidget(title: "some title")),
                    );
                  },
                  child: const Text("Login", style: TextStyle(color: textColorInverted)),
                ),
              )
            ],
          ),
        ),
        children: <Widget>[
          Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  SizedBox(height: deviceHeight(context) * 0.04),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _usernameController, hintText: "Enter your username", validationName: null),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _passwordController, hintText: "Enter your password", validationName: null), // Додано поле паролю
                  ),
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
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await _saveRegistrationData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPageWidget(title: "some title")),
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
