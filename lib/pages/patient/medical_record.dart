import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:lnm_medical_dispensary/pages/patient/view_medical_history.dart';

// ignore: must_be_immutable
class MedRecord extends StatelessWidget {
  MedRecord({ Key? key, required this.patHis }) : super(key: key);

  PatHistory patHis;

  void _requestDownload(String link) async {
    await FlutterDownloader.enqueue(
      url: link,
      savedDir: '/storage/emulated/0/Download',
      showNotification: true,
      openFileFromNotification: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: mqh*0.1,
          backgroundColor: Colors.amber[300],
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title:Container(
            alignment:Alignment.centerRight,
            child: Text(
              "Medical Record",
              style:TextStyle(
                fontSize: mqh*0.044,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )
            ),
          ),
        ),
        backgroundColor: Colors.amber[300],
        body: SafeArea(
          child: Container(
            alignment: Alignment.topRight,
            height: mqh-MediaQuery.of(context).padding.top - AppBar().preferredSize.height,
            width: mqw,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(mqh*0.05),
                      )
                    ),
                    alignment: Alignment.centerRight,
                    width: mqw*0.9,
                    height: mqh*0.82352,
                    child: Container(
                      padding: EdgeInsets.only(right:mqw*0.05),
                      width: mqw*0.88,
                      height: mqh*0.8,
                      child: Column(
                        children:[
                          Container(
                            padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                            width: mqw*0.84,
                            height: mqh*0.8,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: mqh*0.025,
                                  ),
                                  Text(
                                    "Doctor",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                  ),
                                  Text(
                                    "Dr. "+patHis.doctor,
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.05,
                                      color: Colors.black87,
                                    )
                                  ),
                                  SizedBox(
                                    height: mqh*0.035,
                                  ),
                                  Text(
                                    "Timings",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                  ),
                                  Text(
                                    patHis.dateTime.substring(0,8)+", "+patHis.dateTime.substring(9),
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.05,
                                      color: Colors.black87,
                                    )
                                  ),
                                  SizedBox(
                                    height: mqh*0.035,
                                  ),
                                  Text(
                                    "Reason",
                                    textAlign: TextAlign.left,
                                    style:TextStyle(
                                      fontSize: mqw*0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                  ),
                                  Text(
                                    patHis.reason,
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.05,
                                      color: Colors.black87,
                                    )
                                  ),
                                  SizedBox(
                                    height: mqh*0.035,
                                  ),
                                  Text(
                                    "Prescription",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                  ),
                                  Text(
                                    patHis.prescription,
                                    softWrap: true,
                                    maxLines: 10,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:TextStyle(
                                      fontSize: mqw*0.05,
                                      color: Colors.black87,
                                    )
                                  ),
                                  SizedBox(
                                    height: mqh*0.035,
                                  ),
                                  Text(
                                    "Other Instructions",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                  ),
                                  Text(
                                    patHis.instruction,
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:TextStyle(
                                      fontSize: mqw*0.05,
                                      color: Colors.black87,
                                    )
                                  ),
                                  SizedBox(
                                    height: mqh*0.035,
                                  ),
                                  Text(
                                    "Refer to (if any)",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqw*0.06,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    )
                                  ),
                                  Text(
                                    patHis.refer,
                                    softWrap: true,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style:TextStyle(
                                      fontSize: mqw*0.05,
                                      color: Colors.black87,
                                    )
                                  ),
                                  SizedBox(
                                    height: mqh*0.035,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Material(
                                      color: Colors.orange[300],
                                      borderRadius: BorderRadius.circular(mqw*0.03),
                                      child: InkWell(
                                        onTap: () {
                                          _requestDownload('https://firebasestorage.googleapis.com/v0/b/lnmmeddis.appspot.com/o/Vishal%20Gupta.pdf?alt=media&token=8ad40c4d-567b-4f5b-be2c-12d73f0a31c1');
                                        },
                                        child: AnimatedContainer(
                                          duration: const Duration(seconds: 1),
                                          width: mqw*0.7,
                                          height: mqw*0.125,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Download Medical Record",
                                            style: TextStyle(
                                              color: Colors.black87, 
                                              fontWeight: FontWeight.bold,
                                              fontSize: mqh*0.025,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}