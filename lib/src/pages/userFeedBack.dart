import 'package:flutter/material.dart';

import '../widgets/buildNumberField.dart';
import '../widgets/buildFeedBackForm.dart';
import '../widgets/buildCheckList.dart';

class UserFeedback extends StatelessWidget {
  static const routeName = "/feedback";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueGrey,
        ),
        backgroundColor: Colors.white,
        elevation: 2.0,
        centerTitle: true,
        title: Text(
          "Feedback",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'master');
          },
        ),
      ),
      body: SingleChildScrollView(

        
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 10.0),
                // Text(
                //   "Please select a feedback type",
                //   style: TextStyle(
                //     color: Colors.blueGrey,
                //   ),
                // ),
                // SizedBox(height: 5.0),
                // BuildChecklist("Login Trouble"),
                // BuildChecklist("Form submission related"),
                // BuildChecklist("Personal profile"),
                // BuildChecklist("Upload issues"),
                // BuildChecklist("Suggestions"),
                // BuildChecklist("Other issues"),
                SizedBox(
                  height: 5,
                ),
                BuildFeedbackForm(),
                SizedBox(
                  height: 20,
                ),
                BuildNumberField(),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        color: Color(0xffe5e5e5),
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "SUBMIT",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
