import 'package:flutter/material.dart';

class LoginTextFormFieldWidget extends StatefulWidget {
  const LoginTextFormFieldWidget({super.key, required this.hintText});
  final String hintText;

  @override
  State createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormFieldWidget> {
  String hintTextState = "0";

  @override
  Widget build(BuildContext context) {
    if(hintTextState != ""){
      hintTextState=widget.hintText;
    }
    return Focus(
      child: TextFormField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          label: Center(
            child: Text(hintTextState, style: const TextStyle(fontSize: 14)),
          ),
        ),
      ),
      onFocusChange: (hasFocus) {
        if(hasFocus) {
          setState(() {
            hintTextState = "";
          });
        } else {
          setState(() {
            hintTextState = widget.hintText;
          });
        }
      },
    );
  }
}