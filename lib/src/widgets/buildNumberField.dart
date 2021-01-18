import 'package:flutter/material.dart';

class BuildNumberField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0.0),
        prefixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    width: 1.0,
                    color: Color(0xffe5e5e5),
                  ),
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(width: 10.0),
                Text(
                  "+234",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffc5c5c5),
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.cyan,
                ),
                SizedBox(
                  width: 10.0,
                )
              ]),
            ),
            SizedBox(
              width: 10.0,
            )
          ],
        ),
        hintStyle: TextStyle(fontSize: 14.0, color: Color(0xffe5e5e5)),
        hintText: "Phone Number",
        border: OutlineInputBorder(),
      ),
    );
  }
}