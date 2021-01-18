import 'package:flutter/material.dart';
import 'package:ocr_mobile/src/models/dbHelper.dart';
import 'package:ocr_mobile/src/models/loginResponse.dart';

class Profile extends StatefulWidget {
  static const routeName = "/profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final dbHelper = DBHelper();
  bool isPageLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff05a081),
        title: Text("Profile Page"),
        elevation: 0.0,
      ),
      body: StreamBuilder<LoginResponse>(
          stream: dbHelper.getResponse().asStream(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ));
            } else {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(
                        snapshot.data.applicationUserFirstName +
                            " " +
                            snapshot.data.applicationUserLast,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      accountEmail: Text(
                        snapshot.data.applicationUserEmail,
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      currentAccountPicture: GestureDetector(
                        child: CircleAvatar(
                          //return dummy image for now
                          backgroundImage: AssetImage("images/user.png"),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      decoration: BoxDecoration(color: Color(0xff05a081)),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
