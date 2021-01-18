import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ocr_mobile/src/api/restAPI.dart';
import 'package:ocr_mobile/src/component/show_custom_progress_dialog.dart';
import 'package:ocr_mobile/src/component/validation_mixin.dart';
import 'package:ocr_mobile/src/models/dbHelper.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with ValidationMixin {
  bool isLoading = false;

  void initState() {
    super.initState();
  }

  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  FocusNode passwordnode = new FocusNode();
  final dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/bg.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          //now we add a container to the stack
          Container(
            //the more the opacity the lighter or darker the image
            color: Colors.black.withOpacity(0.8),
            height: double.infinity,
            width: double.infinity,
          ),

          Padding(
            padding:
                EdgeInsets.only(top: (MediaQuery.of(context).size.height / 4)),
            child: Container(
              //align our container to the center
              alignment: Alignment.center,
              child: Center(
                child: Form(
                    key: formkey,
                    child: Column(
                      children: <Widget>[
                        //padding for email
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: emailField(), //email
                        ),

                        SizedBox(
                          height: 7,
                        ),
                        //padding for password
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: passwordField(),
                        ),

                        SizedBox(
                          height: 7,
                        ),
                        //padding for login button
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ButtonTheme(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                              ),
                              height: 40,
                              minWidth:
                                  MediaQuery.of(context).size.width * 0.95,
                              child: RaisedButton(
                                  color: Color(0xff05a081),
                                  child: Text('Sign In',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20.0)),
                                  // minWidth: MediaQuery.of(context).size.width,
                                  onPressed: () async {
                                    if (formkey.currentState.validate()) {
                                      formkey.currentState.save();
                                      await ShowCustomProgressDialog
                                          .showLoading(context);
                                      try {
                                        var data = await RestAPI.login(
                                            email, password);

                                        if (data.token.isEmpty) {
                                          //invalid login credentials
                                          Navigator.pop(context);
                                          FocusManager.instance.primaryFocus
                                              .unfocus();
                                          Flushbar(
                                            title: 'Invalid Login!',
                                            message:
                                                'Please check your credentials and try again',
                                            icon: Icon(
                                              Icons.info_outline,
                                              size: 28,
                                              color: Colors.white,
                                            ),
                                            leftBarIndicatorColor: Colors.white,
                                            duration: Duration(seconds: 3),
                                          )..show(context);
                                        } else {
                                          //successful login
                                          //save response
                                          dbHelper.insertToDb(data);
                                          Navigator.pop(context);
                                          Navigator.pushNamed(
                                              context, 'master');
                                        }
                                      } catch (e) {
                                        Navigator.pop(context);
                                        FocusManager.instance.primaryFocus
                                            .unfocus();
                                        Flushbar(
                                          title: 'Something went wrong!',
                                          message: e.message,
                                          icon: Icon(
                                            Icons.info_outline,
                                            size: 28,
                                            color: Colors.white,
                                          ),
                                          leftBarIndicatorColor: Colors.white,
                                          duration: Duration(seconds: 5),
                                        )..show(context);
                                      }
                                    }
                                  }),
                            )),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(passwordnode);
        },
        textInputAction: TextInputAction.next,
        cursorColor: Color(0xff05a081),
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        onSaved: (String value) {
          email = value;
        },
        autocorrect: false,
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          hintText: 'Email Address',
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            Icons.email,
            color: Color(0xff05a081),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
        ));
  }

  Widget passwordField() {
    return TextFormField(
        onFieldSubmitted: (String value) {
          //we can login here as well
        },
        obscureText: true,
        focusNode: passwordnode,
        textInputAction: TextInputAction.done,
        cursorColor: Color(0xff05a081),
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: validatePassword,
        onSaved: (String value) {
          password = value;
        },
        autocorrect: false,
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          hintText: 'Password',
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xff05a081),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
        ));
  }
}
