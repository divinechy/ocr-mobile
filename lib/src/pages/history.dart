import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ocr_mobile/src/api/restAPI.dart';
import 'package:ocr_mobile/src/models/messageResponse.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    // TODO: implement initState
    initDownloader();
    super.initState();
  }

  void initDownloader() async {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize(
        debug: true // optional: set false to disable printing logs to console
        );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ListMessageResponse>(
        stream: RestAPI.getUserHistory().asStream(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            // snapshot.data.myMessages
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            ));
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                    itemCount: snapshot.data.myMessages.length,
                    itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ExpandablePanel(
                            iconPlacement: ExpandablePanelIconPlacement.right,

                            header: Text(snapshot.data.myMessages[i].name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400)),
                            expanded: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Form name: ${snapshot.data.myMessages[i].name}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "Date modified: ${snapshot.data.myMessages[i].date.substring(0, 10)}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.start),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      snapshot.data.myMessages[i].remarks
                                              .isEmpty
                                          ? "Remarks: No remarks"
                                          : "Remarks: ${snapshot.data.myMessages[i].remarks}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // FlatButton(
                                        //   color: Color(0xff05a081),
                                        //   onPressed: () async {
                                        //     try {
                                        //       // go to download url
                                        //   final directory = await getApplicationDocumentsDirectory();
                                        //     final taskId =
                                        //         await FlutterDownloader.enqueue(
                                        //       url: snapshot.data.myMessages[i].formUrl ,
                                        //       savedDir:
                                        //           directory.path,
                                        //       showNotification:
                                        //           true, // show download progress in status bar (for Android)
                                        //       openFileFromNotification:
                                        //           true, // click on notification to open downloaded file (for Android)
                                        //     );  
                                        //     } catch (e) {
                                        //     }
                                            
                                        //   },
                                        //   child: (Text(
                                        //     "Download Form",
                                        //     style:
                                        //         TextStyle(color: Colors.white),
                                        //   )),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // ignore: deprecated_member_use
                            tapHeaderToExpand: true,
                            // ignore: deprecated_member_use
                            hasIcon: true,
                          ),
                        )),
              ),
            );
          }
        });
  }
}
