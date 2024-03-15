import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';
import 'package:flutter/material.dart';

import '../LoginWidgets/login_text_form_field.dart';
import '../main.dart';

class LoginPageWidget extends StatefulWidget {
  const LoginPageWidget({super.key, required this.title});
  final String title;
  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWidget> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
    double deviceWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
    const appColor = Color.fromRGBO(9, 0, 171, 0.8);
    const textColorInverted = Color.fromRGBO(255, 255, 255, 1);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appColor,
        title: const Text('Your Planner', style: TextStyle(color: textColorInverted))
      ),
      body: FooterView(
          footer: Footer(
            backgroundColor: appColor,
            child: Column(
              children: <Widget>[ SizedBox(
                height: deviceHeight(context)*0.03,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyHomePage(title: "some title")),
                    );
                  },
                  child: const Text("Registration", style: TextStyle(color: textColorInverted)),
                )
              )],
            ),
        ),
          children: <Widget>[ Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: deviceHeight(context)*0.2),
                SizedBox(
                  width: deviceWidth(context)/2,
                  height: deviceHeight(context)*0.1,
                  child: const LoginTextFormFieldWidget(hintText: "Enter your username")
                ),
                SizedBox(
                  width: deviceWidth(context)/2,
                  height: deviceHeight(context)*0.1,
                  child: const LoginTextFormFieldWidget(hintText: "Enter your password")
                ),
                SizedBox(height: deviceHeight(context)*0.04),
                SizedBox(
                    width: deviceWidth(context)/2,
                    height: deviceHeight(context)*0.05,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 14)),
                      onPressed: () {},
                      child: const Text('Login'),
                    ),
                )
              ]
            )
          ),
        ],
      )
    );
  }
}