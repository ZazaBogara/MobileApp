import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'Pages/login.dart';
import 'Pages/profile.dart';
import 'controller/storage.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult =  await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalStorage _localStorage = SharedPreferencesStorage();
  final String? loggedInUsername = await _localStorage.getData("logged_in_username");

  bool hasInternet = await checkInternetConnection();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: loggedInUsername != null
        ? hasInternet
        ? const ProfilePageWidget(title: 'Your Planner')
        : _buildNoInternetAlertDialog() // Показати AlertDialog про відсутність з'єднання з Інтернетом
        : const LoginPageWidget(title: 'Flutter Demo Home Page')
  ));
}

AlertDialog _buildNoInternetAlertDialog() {
  return AlertDialog(
    title: const Text('No Internet Connection'),
    content: const Text('Please check your internet connection and try again.'),
    actions: <Widget>[
      TextButton(
        onPressed: () {
          runApp(const ProfilePageWidget(title: 'Your Planner'));
        },
        child: const Text('OK'),
      ),
    ],
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPageWidget(title: 'Flutter Demo Home Page'),
    );
  }
}
