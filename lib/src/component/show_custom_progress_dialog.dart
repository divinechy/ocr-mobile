import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ShowCustomProgressDialog extends StatelessWidget {
  static Future<void> showLoading(BuildContext context) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return SpinKitDoubleBounce(
            color: Color(0xffebf2fa),
            size: 50,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
    );
  }
}
