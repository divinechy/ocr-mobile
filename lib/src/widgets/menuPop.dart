import 'package:flutter/material.dart';

import 'package:ocr_mobile/src/api/restAPI.dart';
import 'package:ocr_mobile/src/models/dbHelper.dart';
import 'package:ocr_mobile/src/pages/login.dart';
import '../pages/userFeedBack.dart';
import '../pages/profile.dart';

enum FilterOptions { Logout, Feedback, Profile }

class MenuPop extends StatelessWidget {
  final dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      padding: EdgeInsets.all(0.0),
      color: Colors.white,
      elevation: 0.0,
      onSelected: (FilterOptions selectedValue) async {
        if (selectedValue == FilterOptions.Profile) {
          try {
            // go to the Profile page
            Navigator.of(context).pushNamed(Profile.routeName);
          } catch (e) {}
        } else if (selectedValue == FilterOptions.Feedback) {
          try {
            // go to feedback form
            Navigator.of(context).pushNamed(UserFeedback.routeName);
          } catch (e) {}
        } else if (selectedValue == FilterOptions.Logout) {
          try {
            //logout here    
            var tk = "";
            RestAPI.saveToken(tk);
            dbHelper.close();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                ModalRoute.withName('login'));
          } catch (e) {}
        } else {
          //nothing happens
        }
      },
      icon: Icon(Icons.menu),
      itemBuilder: (_) => [
        PopupMenuItem(
            child: ListTile(
              title:
                  Text('Profile', style: TextStyle(color: Color(0xff05a081))),
            ),
            value: FilterOptions.Profile),
        PopupMenuItem(
            child: ListTile(
              title:
                  Text('Feedback', style: TextStyle(color: Color(0xff05a081))),
            ),
            value: FilterOptions.Feedback),
        PopupMenuItem(
            child: ListTile(
              title:
                  Text('Log Out', style: TextStyle(color: Color(0xff05a081))),
            ),
            value: FilterOptions.Logout),
      ],
    );
  }
}
