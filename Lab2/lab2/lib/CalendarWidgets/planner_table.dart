import 'package:flutter/material.dart';

class PlannerTable extends StatelessWidget {
  const PlannerTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        border: TableBorder.all(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: Colors.grey[300]),
            children: const [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Time', textAlign: TextAlign.center),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('To-do', textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
          ...generateRows(),
        ],
      ),
    );
  }

  List<TableRow> generateRows() {
    List<TableRow> rows = [];

    for (int hour = 8; hour <= 20; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        String time = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
        rows.add(
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(time, textAlign: TextAlign.center),
                ),
              ),
              TableCell(
                child: Container(),
              ),
            ],
          ),
        );
      }
    }

    return rows;
  }
}
