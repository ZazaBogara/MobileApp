import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Pages/login.dart';
import 'Pages/profile.dart';
import 'controller/storage.dart';
import 'controller/databloc.dart';

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalStorage _localStorage = SharedPreferencesStorage();
  final String? loggedInUsername = await _localStorage.getData("logged_in_username");

  bool hasInternet = await checkInternetConnection();

  runApp(MyApp(
    loggedInUsername: loggedInUsername,
    hasInternet: hasInternet,
  ));
}

class MyApp extends StatelessWidget {
  final String? loggedInUsername;
  final bool hasInternet;

  const MyApp({Key? key, required this.loggedInUsername, required this.hasInternet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DataBloc(SharedPreferencesStorage()), // Use your storage implementation here
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: loggedInUsername != null
            ? hasInternet
            ? const ProfilePageWidget(title: 'Your Planner')
            : _buildNoInternetAlertDialog(context) // Pass context to access Navigator
            : const LoginPageWidget(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  AlertDialog _buildNoInternetAlertDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('No Internet Connection'),
      content: const Text('Please check your internet connection and try again.'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ProfilePageWidget(title: 'Your Planner')),
            );
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
