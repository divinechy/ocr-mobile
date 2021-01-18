import 'package:flutter/material.dart';



class LandingSafeArea extends StatelessWidget {
  const LandingSafeArea({
    Key key,
    @required this.imagecarousel,
  }) : super(key: key);

  final Widget imagecarousel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              imagecarousel,
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text("OCR Mobile",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 2.0,
                        top: 5.0,
                        left: 10.0,
                        right: 10.0,
                      ),
                      child: Text(
                        "The AI-powered document extraction service that understands your forms.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonTheme(
                      // splashColor: Colors.red,
                      height: 40,
                      minWidth: 200,
                      child: RaisedButton(
                        color: Color(0xff05a081),
                        child: Text(
                          "Continue to  Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () async {
                          Navigator.pushNamed(context, 'login');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(
                            30.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
