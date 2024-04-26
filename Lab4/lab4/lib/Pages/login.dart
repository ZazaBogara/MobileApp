import 'package:flutter/material.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../LoginWidgets/login_text_form_field.dart';
import '../Pages/profile.dart';
import '../Pages/registration.dart';
import '../controller/storage.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key, required this.title});
  final String title;

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWidget> {
  final LocalStorage _localStorage = SharedPreferencesStorage(); // Використання класу SharedPreferencesStorage для збереження даних
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<bool> _verifyLogin(String username, String password) async {
    final LocalStorage storage = SharedPreferencesStorage();
    final savedUsername = await storage.getData('username') ?? '';
    final savedPassword = await storage.getData('password') ?? '';
    return username == savedUsername && password == savedPassword;
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
        title: const Text('Your Planner', style: TextStyle(color: textColorInverted)),
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
                      MaterialPageRoute(builder: (context) => const RegistrationPageWidget(title: "some title")),
                    );
                  },
                  child: const Text("Registration", style: TextStyle(color: textColorInverted)),
                ),
              )
            ],
          ),
        ),
        children: <Widget>[
          Center(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always, // Валідація при кожній зміні
              child: Column(
                children: <Widget>[
                  SizedBox(height: deviceHeight(context) * 0.2),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _usernameController, hintText: "Enter your username", validationName: null),
                  ),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.1,
                    child: LoginTextFormFieldWidget(controller: _passwordController, hintText: "Enter your password", validationName: null),
                  ),
                  SizedBox(height: deviceHeight(context) * 0.04),
                  SizedBox(
                    width: deviceWidth(context) / 2,
                    height: deviceHeight(context) * 0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
                        onPressed: () async {
                          var connectivityResult = await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.none) {
                            // Якщо є з'єднання з Інтернетом
                            if (_formKey.currentState!.validate()) {
                              final String username = _usernameController.text;
                              final String password = _passwordController.text;
                              final bool isValid = await _verifyLogin(username, password);
                              if (isValid) {
                                // Зберігаємо дані про користувача
                                await _localStorage.saveData('logged_in_username', username);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const ProfilePageWidget(title: "some title")),
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Login Failed'),
                                      content: const Text('Invalid username or password'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          } else {
                            // Якщо немає з'єднання з Інтернетом
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('No Internet Connection'),
                                  content: const Text('Please check your internet connection and try again.'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                      child: const Text('Login'),
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
