import 'dart:core';
import 'package:flutter/material.dart';
import '../../apis/medrecord_pdf_api.dart';
import '../../apis/pdf_api.dart';
import '../../models/model.dart';
import '../doctor/view_pat_history.dart';

// ignore: must_be_immutable
class MedRecord extends StatelessWidget {
  MedRecord({ Key? key, required this.patHis, required this.patDetails }) : super(key: key);

  PatHistory patHis;
  PatDetails patDetails;

  void buildMedRecord() async {
    var medRec = MedRec(
      patHis: patHis,
      patDetails: patDetails,
    );

    final pdfFile = await PdfMedRecordApi.generate(medRec);
    PdfApi.openFile(pdfFile);
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber[300],
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.amber[300],
        body: SafeArea(
          child: SingleChildScrollView( // REMEMBER TO REMOVE THIS WIDGET
            child: Container(
              alignment: Alignment.bottomRight,
              height: mqh-MediaQuery.of(context).padding.top - AppBar().preferredSize.height,
              width: mqw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment:Alignment.centerLeft,
                    padding: EdgeInsets.only(left:mqw*0.09),
                    child: Text(
                      "Medical Record",
                      style:TextStyle(
                        fontSize: mqh*0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Stack(
                      clipBehavior: Clip.none, 
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(mqh*0.05),
                            )
                          ),
                          alignment: Alignment.bottomRight,
                          width: mqw*0.9,
                          height: mqh*0.8,
                          child: Container(
                            padding: EdgeInsets.only(right:mqw*0.05),
                            width: mqw*0.88,
                            height: mqh*0.755,
                            child: Column(
                              children:[
                                Container(
                                  padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                                  width: mqw*0.84,
                                  height: mqh*0.755,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(), 
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Patient",
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.patient,
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
                                          "Doctor",
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          "Dr. "+patHis.doctor,
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
                                          "Timings",
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.dateTime.substring(0,10)+", "+patHis.dateTime.substring(11),
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
                                          "Prescription",
                                          textAlign: TextAlign.left,
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
                                          textAlign: TextAlign.left,
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
                                          textAlign: TextAlign.left,
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
                                                buildMedRecord();
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(seconds: 1),
                                                width: mqw*0.7,
                                                height: mqw*0.125,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "View Medical Record PDF",
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
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}