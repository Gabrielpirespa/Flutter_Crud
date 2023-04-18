import 'package:flutter/material.dart';
import 'package:flutter_crud/themes/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TestListItem extends StatefulWidget {
  final String task;
  final String date;
  final int? taskId;

  const TestListItem(
      {Key? key, required this.task, required this.date, this.taskId})
      : super(key: key);

  @override
  State<TestListItem> createState() => _TestListItemState();
}

class _TestListItemState extends State<TestListItem> {
  bool _checkbox = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, bottom: 16),
      child: Container(
        constraints: BoxConstraints(
          minHeight: mediaQuery.size.height * 0.12,
          maxWidth: mediaQuery.size.width,
        ),
        decoration: BoxDecoration(
            boxShadow: kElevationToShadow[3],
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CheckboxListTile(
              title: Text(
                widget.task,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                widget.date,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              activeColor: fabColor,
              value: _checkbox,
              onChanged: (bool? value) {
                setState(() {
                  _checkbox = !_checkbox;
                });
              }),
        ),
      ),
    );
  }
}
