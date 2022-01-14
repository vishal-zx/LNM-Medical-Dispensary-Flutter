import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


class ViewMedCertReqs extends StatefulWidget {
  const ViewMedCertReqs({ Key? key }) : super(key: key);

  @override
  _ViewMedCertReqsState createState() => _ViewMedCertReqsState();
}

enum CertStatus {
  none,
  approved,
  pending,
  rejected,
}

class MedCertRequests{
  String doctor = "";
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  CertStatus status = CertStatus.none;
  String reason = "";
  String certUrl = "";

  MedCertRequests(this.doctor, this.fromDate, this.toDate, this.status, this.reason, this.certUrl);
}

class _ViewMedCertReqsState extends State<ViewMedCertReqs> {
  final formKey = GlobalKey<FormState>();

  List<MedCertRequests> medCertsReqs = [
      MedCertRequests('Vishal Gupta', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever fever fever fever fever fever in order to open APK files, your application needs', ''),
      MedCertRequests('Chand Singh', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.pending, 'fever', ''),
      MedCertRequests('Amit Malhotra', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Nidhi Bisht', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.rejected, 'fever', ''),
      MedCertRequests('Vishal Gupta', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.pending, 'fever', ''),
      MedCertRequests('Chand Singh', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Amit Malhotra', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.rejected, 'fever in order to open APK files, your application needs', ''),
      MedCertRequests('Nidhi Bisht', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.rejected, 'fever', ''),
      MedCertRequests('Vishal Gupta', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.pending, 'fever', ''),
      MedCertRequests('Chand Singh', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Amit Malhotra', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.rejected, 'fever', ''),
      MedCertRequests('Nidhi Bisht', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Vishal Gupta', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.pending, 'fever', ''),
      MedCertRequests('Chand Singh', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.rejected, 'fever', ''),
      MedCertRequests('Amit Malhotra', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Nidhi Bisht', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.pending, 'fever', ''),
      MedCertRequests('Vishal Gupta', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Chand Singh', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.rejected, 'fever', ''),
      MedCertRequests('Amit Malhotra', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
      MedCertRequests('Nidhi Bisht', DateTime.now(), DateTime.now().add(const Duration(days:2)), CertStatus.approved, 'fever', ''),
  ];

  @override
  void initState(){
    // FlutterDownloader.initialize();
    super.initState();
  }

  void _requestDownload(String link) async {
    FlutterDownloader.initialize().then((value)async{
      final taskId = await FlutterDownloader.enqueue(
        url: link,
        savedDir: '/storage/emulated/0/Download',
        showNotification: true, // show download progress in status bar (for Android)
        openFileFromNotification: true, // click on notification to open downloaded file (for Android)
     );
    });
    
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.amber[300],
        body: SafeArea(
          child: SingleChildScrollView( // REMEMBER TO REMOVE THIS WIDGET
            child: Container(
              alignment: Alignment.bottomRight,
              height: mqh-MediaQuery.of(context).padding.top,
              width: mqw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left:mqw*0.11),
                    child: Text(
                      "View Medical Certificates Requests",
                      style:TextStyle(
                        fontSize: mqh*0.044,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )
                    )
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
                          child: SizedBox(
                            width: mqw*0.88,
                            height: mqh*0.755,
                            child: SingleChildScrollView(
                              child: Column(
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(left:mqw*0.05, right:mqw*0.02),
                                    width: mqw*0.84,
                                    height: mqh*0.755,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(), 
                                      itemCount: medCertsReqs.length,
                                      itemBuilder: (context, index){
                                        return Row(
                                          mainAxisAlignment:MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height:mqh*0.2,
                                              child: Card(  
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(mqh*0.01))
                                                ),
                                                color: Colors.amber[200],
                                                child: SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.all(mqw*0.04),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: mqw*0.46,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons.person,
                                                                    size: mqh*0.025
                                                                  ),
                                                                  Text(
                                                                    " Dr. "+medCertsReqs[index].doctor,
                                                                    textAlign: TextAlign.center,
                                                                    style:TextStyle(
                                                                      fontSize: mqw*0.04,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black87,
                                                                    )
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: mqh*0.015,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children:[
                                                                  Text(
                                                                    "Reason: ",
                                                                    style:TextStyle(
                                                                      fontSize: mqw*0.035,
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.black87,
                                                                    )
                                                                  ),
                                                                  Text(
                                                                    medCertsReqs[index].reason,
                                                                    softWrap: true,
                                                                    maxLines: 2,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    style:TextStyle(
                                                                      fontSize: mqw*0.035,
                                                                      color: Colors.black87,
                                                                    )
                                                                  ),
                                                                  SizedBox(
                                                                    height: mqh*0.01,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(
                                                                        "Period Requested:",
                                                                        textAlign: TextAlign.center,
                                                                        style:TextStyle(
                                                                          fontSize: mqw*0.035,
                                                                          fontWeight: FontWeight.bold,
                                                                          color: Colors.black87,
                                                                        )
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Text(
                                                                            DateFormat("dd/MM/yy").format(medCertsReqs[index].fromDate),
                                                                            textAlign: TextAlign.center,
                                                                            style:TextStyle(
                                                                              fontSize: mqw*0.035,
                                                                              color: Colors.black87,
                                                                            )
                                                                          ),
                                                                          Text(
                                                                            " To ",
                                                                            textAlign: TextAlign.center,
                                                                            style:TextStyle(
                                                                              fontSize: mqw*0.035,
                                                                              color: Colors.black87,
                                                                            )
                                                                          ),
                                                                          Text(
                                                                            DateFormat("dd/MM/yy").format(medCertsReqs[index].toDate),
                                                                            textAlign: TextAlign.center,
                                                                            style:TextStyle(
                                                                              fontSize: mqw*0.035,
                                                                              color: Colors.black87,
                                                                            )
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ]
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
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return BackdropFilter(
                                                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                      child: AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(mqh*0.02),
                                                        ),
                                                        backgroundColor: (medCertsReqs[index].status == CertStatus.approved)?Colors.green[200]:
                                                          (medCertsReqs[index].status == CertStatus.rejected)?Colors.red[200]:Colors.orange[200],
                                                        title: Text(
                                                          'Request : '+((medCertsReqs[index].status == CertStatus.approved)?" Approved":
                                                          (medCertsReqs[index].status == CertStatus.rejected)?" Rejected":" Pending"),
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: mqw*0.05,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        titlePadding: EdgeInsets.only(top: mqh*0.02),
                                                        contentPadding: EdgeInsets.zero,
                                                        actionsPadding: (medCertsReqs[index].status == CertStatus.approved)?EdgeInsets.zero:EdgeInsets.only(bottom: mqh*0.015),
                                                        actionsAlignment: MainAxisAlignment.center,
                                                        actions: <Widget>[
                                                          if(medCertsReqs[index].status == CertStatus.approved)
                                                            TextButton(
                                                            child: Text(
                                                              "Download Medical Certificate",
                                                              style: TextStyle(
                                                                fontSize: mqw*0.045,
                                                                color: Colors.black,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            onPressed: () {
                                                              _requestDownload('https://firebasestorage.googleapis.com/v0/b/lnmmeddis.appspot.com/o/Vishal%20Gupta.pdf?alt=media&token=8ad40c4d-567b-4f5b-be2c-12d73f0a31c1');
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                          if(medCertsReqs[index].status == CertStatus.pending)
                                                            Text(
                                                              "Your request is still pending !",
                                                              style: TextStyle(
                                                                fontSize: mqw*0.045,
                                                                color: Colors.black,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          if(medCertsReqs[index].status == CertStatus.rejected)
                                                            Text(
                                                              "Sorry, your request was rejected by the doctor.",
                                                              style: TextStyle(
                                                                fontSize: mqw*0.045,
                                                                color: Colors.black,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                        ]
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: SizedBox(
                                                height:mqh*0.2,
                                                width: mqw*0.2,
                                                child: Card(  
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.horizontal(right: Radius.circular(mqh*0.01))
                                                  ),
                                                  color: (medCertsReqs[index].status == CertStatus.approved)?Colors.green[400]:
                                                          (medCertsReqs[index].status == CertStatus.rejected)?Colors.red[400]:Colors.orange[400],
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: RotatedBox(
                                                      quarterTurns: 3,
                                                      child: Text(
                                                        (medCertsReqs[index].status == CertStatus.approved)?" Approved":
                                                        (medCertsReqs[index].status == CertStatus.rejected)?" Rejected":" Pending",
                                                        textAlign: TextAlign.center,
                                                        style:TextStyle(
                                                          fontSize: mqw*0.05,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ),
                                            )
                                          ],
                                        );
                                      }
                                    ),
                                  ),
                                ]
                              )
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