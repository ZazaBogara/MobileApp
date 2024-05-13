import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../LoginWidgets/login_text_form_field.dart';
import '../Pages/profile.dart';
import '../Pages/registration.dart';
import '../controller/storage.dart';
import '../controller/databloc.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(9, 0, 171, 0.8),
        title: const Text('Your Planner', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: BlocProvider(
                create: (context) => DataBloc(SharedPreferencesStorage()),
                child: LoginForm(),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPageWidget(title: "some title")),
                );
              },
              child: Container(
                color: const Color.fromRGBO(9, 0, 171, 0.8), // Background color matching app bar
                alignment: Alignment.center,
                child: const Text("Registration", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}
class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int counter = 1;
  void save_logged_in_username() async {
    await Future.delayed(const Duration(milliseconds: 20));
    if(counter == 1) {
      counter++;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePageWidget(
            title: 'Your Planner')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DataBloc, DataState>(
      listener: (context, state) {

        if (state is DataLoaded) {
          BlocProvider.of<DataBloc>(context).add(UpdateDataEvent('logged_in_username', _usernameController.text));
          save_logged_in_username();
        } else if (state is DataError) {
          // Handle login error
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
      },
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: LoginTextFormFieldWidget(controller: _usernameController, hintText: "Enter your username", validationName: "Name"),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: LoginTextFormFieldWidget(controller: _passwordController, hintText: "Enter your password", validationName: "Password"),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height * 0.05,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
                onPressed: () async {
                  var connectivityResult = await Connectivity().checkConnectivity();
                  if (connectivityResult != ConnectivityResult.none) {
                    if (_formKey.currentState!.validate()) {
                      final String username = _usernameController.text;
                      final String password = _passwordController.text;
                      // Dispatch FetchDataEvent to perform login
                      BlocProvider.of<DataBloc>(context).add(FetchDataEvent(username));
                    }
                  } else {
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
    );
  }
}
