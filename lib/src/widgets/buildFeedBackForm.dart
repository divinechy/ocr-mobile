import 'package:flutter/material.dart';


class BuildFeedbackForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: Stack(children: [
        TextField(
          maxLines: 10,
          decoration: InputDecoration(
            hintText: "Please briefly describe the issue",
            hintStyle: TextStyle(
              fontSize: 13.0,
              color: Color(0xffc5c5c5),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffe5e5e5),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1.0,
                  color: Color(0xffa6a6a6),
                ),
              ),
            ),
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffe5e5e5),
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add,
                      color: Color(0xffa5a5a5),
                    ),
                  ),
                ),
                SizedBox(width: 4.0),
                Text(
                  "Upload screenshot (optional) ",
                  style: TextStyle(
                    color: Color(0xffc5c5c5),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}