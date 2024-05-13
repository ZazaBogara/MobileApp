import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/databloc.dart';

class PlannerHeader extends StatelessWidget {
  const PlannerHeader({Key? key}) : super(key: key);

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
              // Dispatch event to go to previous date
              //BlocProvider.of<DataBloc>(context).add(PreviousDateEvent());
            },
          ),
          const Text("today"),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              // Dispatch event to go to next date
              //BlocProvider.of<DataBloc>(context).add(NextDateEvent());
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              // Dispatch event to open calendar
              //BlocProvider.of<DataBloc>(context).add(OpenCalendarEvent());
            },
          ),
        ],
      ),
    );
  }
}
