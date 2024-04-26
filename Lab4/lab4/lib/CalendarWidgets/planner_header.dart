import 'package:flutter/material.dart';

class PlannerHeader extends StatelessWidget {
  const PlannerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {

            },
          ),
          const Text('02.04.2024'),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {

            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}
