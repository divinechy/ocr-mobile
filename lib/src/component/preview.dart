import 'dart:convert';
import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mobile/src/api/restAPI.dart';
import 'package:ocr_mobile/src/component/pdfpagepreview.dart';
import 'package:ocr_mobile/src/component/result.dart';
import 'package:ocr_mobile/src/component/show_custom_progress_dialog.dart';
import 'package:ocr_mobile/src/models/form.dart';

class Preview extends StatefulWidget {
  final String imgPath;
  final String pdfPath;
  final dynamic pdfPreviewPath;

  Preview({this.imgPath, this.pdfPath, this.pdfPreviewPath});
  @override
  _PreviewState createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  bool isUrlRecieved = false;
  String url = "";
  MyForm newForm = MyForm();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: widget.pdfPath != null
                ? PdfPagePreview(imgPath: widget.pdfPreviewPath)
                : Image.file(
                    File(widget.imgPath),
                    fit: BoxFit.cover,
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: double.infinity,
                height: 50,
                color: Color(0xff05a081),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(context);
                        },
                        child: Text(
                          "Back",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        )),
                    isUrlRecieved
                        ? FlatButton(
                            child: Text(
                              "Recognize Form",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () async {
                              await ShowCustomProgressDialog.showLoading(
                                  context);
                              try {
                                //get result
                                var res = await RestAPI.getResult(url);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Result(
                                              data: res,
                                              form: newForm,
                                            )));
                              } catch (e) {
                                if (e == "Unauthorized") {
                                  Navigator.pop(context);
                                  Flushbar(
                                    title: 'Login session expired!',
                                    message: "Please Login again",
                                    icon: Icon(
                                      Icons.info_outline,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    leftBarIndicatorColor: Colors.white,
                                    duration: Duration(seconds: 4),
                                  )..show(context).then((value) =>
                                      Navigator.popUntil(context,
                                          ModalRoute.withName('login')));
                                } else if (e == "notStarted") {
                                  Navigator.pop(context);
                                  Flushbar(
                                    title: 'Please Recognize Form Again!',
                                    message: "Form service not yet started",
                                    icon: Icon(
                                      Icons.info_outline,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    leftBarIndicatorColor: Colors.white,
                                    duration: Duration(seconds: 4),
                                  )..show(context);
                                } else {
                                  Navigator.pop(context);
                                  Flushbar(
                                    title: 'Something went wrong!',
                                    message: e,
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
                            },
                          )
                        : FlatButton(
                            child: Text(
                              "Submit Form",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                            onPressed: () async {
                              await ShowCustomProgressDialog.showLoading(
                                  context);
                              String baseString = "";
                              if (widget.imgPath != null) {
                                baseString = await getbase64(widget.imgPath);
                              } else {
                                baseString = await getbase64(widget.pdfPath);
                              }
                              setState(() {
                                newForm = MyForm(
                                    image: baseString,
                                    imageType: widget.imgPath != null
                                        ? "image/jpeg"
                                        : "application/pdf");
                              });

                              try {
                                var data = await RestAPI.submitForm(newForm);
                                if (data.status == false) {
                                  //invalid response
                                  Navigator.pop(context);
                                  Flushbar(
                                    title: 'Invalid File!',
                                    message:
                                        'Uploaded File not recognized, please try again',
                                    icon: Icon(
                                      Icons.info_outline,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    leftBarIndicatorColor: Colors.white,
                                    duration: Duration(seconds: 3),
                                  )..show(context);
                                } else {
                                  //get form url here and attempt to get result
                                  setState(() {
                                    url = data.message;
                                    isUrlRecieved = true;
                                  });
                                  Navigator.of(context).pop();
                                }
                              } catch (e) {
                                if (e == "Unauthorized") {
                                  Navigator.pop(context);
                                  Flushbar(
                                    title: 'Login session expired!',
                                    message: "Please Login again",
                                    icon: Icon(
                                      Icons.info_outline,
                                      size: 28,
                                      color: Colors.white,
                                    ),
                                    leftBarIndicatorColor: Colors.white,
                                    duration: Duration(seconds: 4),
                                  )..show(context).then((value) =>
                                      Navigator.popUntil(context,
                                          ModalRoute.withName('login')));
                                } else {
                                  Navigator.pop(context);
                                  Flushbar(
                                    title: 'Something went wrong!',
                                    message: e,
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
                            },
                          )
                  ],
                )),
          )
        ],
      ),
    );
  }

//convert image to base 64 string
  Future<String> getbase64(dynamic data) async {
    var file = File(data).readAsBytesSync();
    var baseString = base64Encode(file);
    return baseString;
  }
}
