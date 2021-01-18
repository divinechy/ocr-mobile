import 'dart:io';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mobile/src/component/preview.dart';
import 'package:ocr_mobile/src/component/show_custom_progress_dialog.dart';
import 'package:pdf_previewer/pdf_previewer.dart';

class OCR extends StatefulWidget {
  @override
  _OCRState createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset("images/nodata11.jpg",
                height: MediaQuery.of(context).size.height * 0.45),
            SizedBox(height: 90),
            Align(
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: FlatButton(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.18),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.cloud_upload,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      title: Text(
                                        "Upload Form",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20),
                                      ),
                                      onTap: () async {
                                        await ShowCustomProgressDialog
                                            .showLoading(context);
                                        try {
                                          FilePickerCross result =
                                              await FilePickerCross
                                                  .importFromStorage(
                                            type: FileTypeCross.custom,
                                            fileExtension: '.pdf, .png, .jpg',
                                          );
                                          if (result != null) {
                                            var ext =
                                                result.fileName.split('.').last;
                                            if (ext == 'pdf' ||
                                                ext == 'png' ||
                                                ext == 'jpg') {
                                              var path = result.path;
                                              if (ext == 'pdf') {
                                                //pdf file
                                                var previewPath =
                                                    await PdfPreviewer
                                                        .getPagePreview(
                                                            filePath: path,
                                                            pageNumber: 1);

                                                //push pdf to pdf preview
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Preview(
                                                              pdfPath: path,
                                                              pdfPreviewPath:
                                                                  previewPath,
                                                            )),
                                                    ModalRoute.withName(
                                                        'master'));
                                              } else {
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Preview(
                                                              imgPath: path,
                                                            )),
                                                    ModalRoute.withName(
                                                        'master'));
                                              }
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
                                              duration: Duration(seconds: 4),
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
                                              duration: Duration(seconds: 4),
                                            )..show(context);
                                          }
                                        }
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(
                                        Icons.photo_camera,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      title: Text(
                                        "Snap Form",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 20),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(context, 'camera');
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        color: Color(0xff05a081),
                        splashColor: Theme.of(context).primaryColor,
                        child: Text(
                          "Upload/Capture Form",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )))),
          ],
        ),
      ),
    ]);
  }
}
