import 'package:flutter/material.dart';

class BuildChecklist extends StatelessWidget {
  final String title;

  BuildChecklist(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(children: [
        Icon(
          Icons.check_circle,
          color: Colors.blueGrey,
        ),
        SizedBox(
          height: 1.0,
          width: 5.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ]),
    );
  }
}