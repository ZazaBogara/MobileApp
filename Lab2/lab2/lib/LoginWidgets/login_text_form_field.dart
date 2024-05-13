import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/databloc.dart';

// Define event for updating text field value
class UpdateTextFieldValueEvent extends DataEvent {
  final String key;
  final String value;

  UpdateTextFieldValueEvent(this.key, this.value);
}

class LoginTextFormFieldWidget extends StatelessWidget {
  const LoginTextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.validationName,
    this.controller,
  });

  final String hintText;
  final String validationName;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataBloc, DataState>(
      builder: (context, state) {
        return TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            labelText: hintText,
          ),
          onChanged: (value) {
            // Dispatch event to update text field value
            BlocProvider.of<DataBloc>(context).add(UpdateTextFieldValueEvent(validationName, value));
          },
          validator: (value) {
            if (validationName == "Date") {
              const datePattern = r'^\d{2}\.\d{2}\.\d{4}$';
              final regExp = RegExp(datePattern);
              if (!regExp.hasMatch(value!)) {
                return 'Invalid date format. Please enter in format 22.03.2013';
              }
            } else if (validationName == "Email") {
              if (!value!.contains('@')) {
                return 'Invalid email address';
              }
            } else if (validationName == "Name") {
              if (value!.contains(RegExp(r'[0-9]'))) {
                return 'Name cannot contain numbers';
              }
            }
            return null;
          },
        );
      },
    );
  }
}
