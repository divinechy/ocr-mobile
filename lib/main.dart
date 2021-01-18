import 'package:flutter/material.dart';

import 'package:ocr_mobile/src/component/camera.dart';
import 'package:ocr_mobile/src/component/myColors.dart';
import 'package:ocr_mobile/src/pages/profile.dart';
import 'src/pages/userFeedBack.dart';
import 'package:ocr_mobile/src/pages/landing.dart';
import 'package:ocr_mobile/src/pages/login.dart';
import 'package:ocr_mobile/src/pages/master.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: MyColors.PrimaryColor,
        accentColor: Colors.amber[500],
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      debugShowCheckedModeBanner: false,
      home: Landing(),
      routes: <String, WidgetBuilder>{
        'login': (BuildContext context) => Login(),
        'master': (BuildContext context) => Master(),
        'camera': (BuildContext context) => Camera(),
        UserFeedback.routeName: (context) => UserFeedback(),
        Profile.routeName: (context) => Profile(),
      },
    ),
  );
}
