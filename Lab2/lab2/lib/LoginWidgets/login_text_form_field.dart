import 'package:flutter/material.dart';

class LoginTextFormFieldWidget extends StatefulWidget {
  const LoginTextFormFieldWidget({super.key, required this.hintText, this.validationName, this.controller});
  final String hintText;
  final String? validationName;
  final TextEditingController? controller;

  @override
  State createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormFieldWidget> {
  late String hintTextState;
  late bool validate;

  @override
  void initState() {
    super.initState();
    hintTextState = widget.hintText;
    validate = false;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: hintTextState,
        ),
        validator: (value) {
          if (widget.validationName == "Date") {
            const datePattern = r'^\d{2}\.\d{2}\.\d{4}$';
            final regExp = RegExp(datePattern);
            if (!regExp.hasMatch(value!)) {
              return 'Invalid date format. Please enter in format 22.03.2013';
            }
          } else if (widget.validationName == "Email") {
            if (!value!.contains('@')) {
              return 'Invalid email address';
            }
          } else if (widget.validationName == "Name") {
            if (value!.contains(RegExp(r'[0-9]'))) {
              return 'Name cannot contain numbers';
            }
          }
          return null;
        },
        onChanged: (value) {
          if (validate) {
            setState(() {
              validate = false;
            });
          }
        },
      ),
      onFocusChange: (hasFocus) {
        if (hasFocus) {
          setState(() {
            hintTextState = '';
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
