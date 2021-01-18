import 'dart:convert';
import 'dart:io';

import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:ocr_mobile/src/api/restAPI.dart';
import 'package:ocr_mobile/src/component/show_custom_progress_dialog.dart';
import 'package:ocr_mobile/src/models/form.dart';
import 'package:ocr_mobile/src/models/saveResult.dart';

class Result extends StatefulWidget {
  final List<Map<String, String>> data;
  final MyForm form;
  Result({this.data, this.form});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Alignment childAlignment = Alignment.center;
  FocusNode remarkNode = new FocusNode();
  TextEditingController titleText = new TextEditingController();
  TextEditingController remarkText = new TextEditingController();
  String ext;
  String baseString;
  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        setState(() {
          childAlignment = visible ? Alignment.topCenter : Alignment.center;
        });
        print('keyboard $visible');
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    titleText.text = "";
    remarkText.text = "";
    super.dispose();
  }

  void saveResult() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: titleField(),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: remarkField(),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ButtonTheme(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                      height: 40,
                      minWidth: MediaQuery.of(context).size.width * 0.70,
                      child: RaisedButton(
                          color: Color(0xff05a081),
                          child: Text('Save',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.0)),
                          // minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            //get items to save and call save API
                            FocusManager.instance.primaryFocus.unfocus();
                            await ShowCustomProgressDialog.showLoading(context);
                            try {
                              var res = jsonEncode(widget.data);
                              SaveResult _saver = new SaveResult(
                                  name: titleText.text,
                                  remarks: remarkText.text,
                                  result: res,
                                  document: baseString,
                                  documentType: ext == null
                                      ? ""
                                      : ext == 'pdf'
                                          ? "application/pdf"
                                          : "image/jpg",
                                  form: widget.form);

                              var response = await RestAPI.saveResult(_saver);

                              if (response.status == true) {
                                Navigator.pop(context);
                                Flushbar(
                                  title: 'Result saved successfully!',
                                  message: response.message,
                                  icon: Icon(
                                    Icons.sentiment_satisfied,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                  leftBarIndicatorColor: Color(0xff05a081),
                                  duration: Duration(seconds: 7),
                                )..show(context).then((value) =>
                                    Navigator.popUntil(context,
                                        ModalRoute.withName('master')));
                              } else {
                                Navigator.pop(context);
                                Flushbar(
                                  title: 'Result failed to save',
                                  message: response.message,
                                  icon: Icon(
                                    Icons.sentiment_dissatisfied,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                  leftBarIndicatorColor: Color(0xff05a081),
                                  duration: Duration(seconds: 7),
                                )..show(context).then((value) =>
                                    Navigator.popUntil(context,
                                        ModalRoute.withName('master')));
                              }
                            } catch (e) {
                              Navigator.pop(context);
                              FocusManager.instance.primaryFocus.unfocus();
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
                          })))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Scaffold(
            body: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 400),
                alignment: childAlignment,
                child: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 30.0,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color(0xff05a081),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Text('Result',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 23.0,
                                fontWeight: FontWeight.w600)),
                      ),
                      Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                              child: DataTable(
                                  showCheckboxColumn: false,
                                  headingRowHeight: 20,
                                  columnSpacing: 30,
                                  horizontalMargin: 15,
                                  dataRowHeight: 80,
                                  columns: <DataColumn>[
                                    DataColumn(
                                      label: Text("Field",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                    DataColumn(
                                      label: Text("Value",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ],
                                  rows: widget.data
                                      .asMap()
                                      .map((i, datum) => MapEntry(
                                          i,
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  child: Text(
                                                    '${datum.keys.reduce((value, element) => null)}'
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  child: TextFormField(
                                                    autofocus: false,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    onFieldSubmitted:
                                                        (String value) {
                                                      //get current index of data cell
                                                      SystemChannels.textInput
                                                          .invokeMethod(
                                                              'TextInput.hide');
                                                      //update keyvalue pair data here
                                                      setState(() {
                                                        widget.data
                                                            .elementAt(
                                                                i)[datum.keys
                                                            .reduce((value,
                                                                    element) =>
                                                                null)] = value;
                                                      });

                                                      print(value);
                                                      print(widget.data
                                                          .elementAt(i)
                                                          .values
                                                          .first);
                                                    },
                                                    maxLines: null,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                            hintText: null),
                                                    initialValue:
                                                        '${datum.values.reduce((value, element) => null)}',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                  ),
                                                ),
                                                showEditIcon: false,
                                              ),
                                            ],
                                          )))
                                      .values
                                      .toList()))),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          color: Color(0xff05a081),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlatButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, 'master');
                                  },
                                  child: Text("Home",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))),
                              FlatButton(
                                  child: Text("Save",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                  onPressed: () {
                                    //add supporting document and save
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: InkWell(
                                                  child: Text(
                                                    "Add Supporting Doc",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  onTap: () async {
                                                    print("alright..");
                                                    try {
                                                      //uploading supporting document will not be previewed
                                                      //get a notification doument added and save
                                                      await ShowCustomProgressDialog
                                                          .showLoading(context);
                                                      FilePickerCross result =
                                                          await FilePickerCross
                                                              .importFromStorage(
                                                        type: FileTypeCross
                                                            .custom,
                                                        fileExtension:
                                                            '.pdf, .png, .jpg',
                                                      );
                                                      if (result != null) {
                                                        ext = result.fileName
                                                            .split('.')
                                                            .last;
                                                        if (ext == 'pdf' ||
                                                            ext == 'png' ||
                                                            ext == 'jpg') {
                                                          var path =
                                                              result.path;
                                                          //convert to base64 here
                                                          baseString =
                                                              await getbase64(
                                                                  path);
                                                          Navigator.pop(
                                                              context);
                                                          Flushbar(
                                                            title:
                                                                'Supporting document added',
                                                            message:
                                                                "Document added successfully!",
                                                            icon: Icon(
                                                              Icons
                                                                  .info_outline,
                                                              size: 28,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            leftBarIndicatorColor:
                                                                Colors.white,
                                                            duration: Duration(
                                                                seconds: 3),
                                                          )..show(context);
                                                          saveResult();
                                                        } else {
                                                          throw 'Only Images and PDF files are allowed';
                                                        }
                                                      }
                                                    } catch (e) {
                                                      if (e is String) {
                                                        Navigator.pop(context);
                                                        Flushbar(
                                                          title:
                                                              'Upload file not successful',
                                                          message: e,
                                                          icon: Icon(
                                                            Icons.info_outline,
                                                            size: 28,
                                                            color: Colors.white,
                                                          ),
                                                          leftBarIndicatorColor:
                                                              Colors.white,
                                                          duration: Duration(
                                                              seconds: 4),
                                                        )..show(context);
                                                      } else {
                                                        Navigator.pop(context);
                                                        Flushbar(
                                                          title:
                                                              'Upload file not successful',
                                                          message: e.message,
                                                          icon: Icon(
                                                            Icons.info_outline,
                                                            size: 28,
                                                            color: Colors.white,
                                                          ),
                                                          leftBarIndicatorColor:
                                                              Colors.white,
                                                          duration: Duration(
                                                              seconds: 4),
                                                        )..show(context);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: InkWell(
                                                  child: Text(
                                                    "Continue Saving",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  onTap: () {
                                                    print("okay..");
                                                    //call to save result
                                                    saveResult();
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  })
                            ],
                          ),
                        ),
                      )
                    ])))));
  }

  Widget titleField() {
    return TextFormField(
        onFieldSubmitted: (String value) {
          print(value);
          remarkNode.requestFocus();
        },
        textInputAction: TextInputAction.next,
        cursorColor: Color(0xff05a081),
        autofocus: false,
        keyboardType: TextInputType.text,
        autocorrect: true,
        controller: titleText,
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          hintText: 'Title',
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            Icons.text_format,
            color: Color(0xff05a081),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
        ));
  }

  Widget remarkField() {
    return TextFormField(
        onFieldSubmitted: (String value) {},
        focusNode: remarkNode,
        textInputAction: TextInputAction.done,
        cursorColor: Color(0xff05a081),
        autofocus: false,
        keyboardType: TextInputType.text,
        autocorrect: true,
        controller: remarkText,
        decoration: InputDecoration(
          //or increase multilinepading
          contentPadding:
              new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          hintText: 'Remark',
          errorStyle: TextStyle(fontWeight: FontWeight.bold),
          prefixIcon: Icon(
            Icons.note,
            color: Color(0xff05a081),
          ),
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Color(0xff05a081), width: 2),
          ),
        ));
  }

  Future<String> getbase64(dynamic data) async {
    var file = File(data).readAsBytesSync();
    var baseString = base64Encode(file);
    return baseString;
  }
}
