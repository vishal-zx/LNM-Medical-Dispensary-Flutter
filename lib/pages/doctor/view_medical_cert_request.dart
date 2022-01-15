import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_downloader/flutter_downloader.dart';


class MedCertReqs extends StatefulWidget {
  const MedCertReqs({ Key? key }) : super(key: key);

  @override
  _MedCertReqsState createState() => _MedCertReqsState();
}

enum CertStatus {
  none,
  approved,
  pending,
  rejected,
}

class MedCertRequests{
  String patient = "";
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();
  CertStatus status = CertStatus.none;
  String reason = "";
  String certUrl = "";

  MedCertRequests(this.patient, this.fromDate, this.toDate, this.status, this.reason, this.certUrl);
}

class _MedCertReqsState extends State<MedCertReqs> {
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
  ];

  @override
  void initState(){
    super.initState();
  }

  void _requestDownload(String link) async {
    FlutterDownloader.initialize().then((value)async{
      FlutterDownloader.enqueue(
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
        backgroundColor: Colors.cyan[300],
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
                      "Medical Certificates Requests",
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
                            color: Colors.cyan[100],
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
                                    padding: EdgeInsets.only(left:mqw*0.035, right:mqw*0.02),
                                    width: mqw*0.84,
                                    height: mqh*0.755,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(), 
                                      itemCount: medCertsReqs.length,
                                      itemBuilder: (context, index){
                                        return SizedBox(
                                          height:mqh*0.25,
                                          child: Card(  
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(mqh*0.01)
                                            ),
                                            color: Colors.cyan.shade300,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(      
                                                  padding: EdgeInsets.all(mqw*0.03),
                                                  height: mqh*0.175,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(mqh*0.01),
                                                      bottomLeft: Radius.circular(mqh*0.01),
                                                    )
                                                  ),
                                                  alignment: Alignment.centerLeft,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Patient:",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              " "+ medCertsReqs[index].patient,
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              softWrap:false,
                                                              maxLines: 1,
                                                              style:TextStyle(
                                                                fontSize: mqw*0.04,
                                                                color: Colors.black87,
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Certificate Requested From:",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              " "+ DateFormat("dd-MM-yy").format(medCertsReqs[index].fromDate),
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              softWrap:false,
                                                              maxLines: 1,
                                                              style:TextStyle(
                                                                fontSize: mqw*0.04,
                                                                color: Colors.black87,
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Certificate Requested To:",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              " "+ DateFormat("dd-MM-yy").format(medCertsReqs[index].toDate),
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              softWrap:false,
                                                              maxLines: 1,
                                                              style:TextStyle(
                                                                fontSize: mqw*0.04,
                                                                color: Colors.black87,
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Reason:",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          SizedBox(
                                                            width:mqw*0.01
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              medCertsReqs[index].reason,
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              softWrap:false,
                                                              maxLines: 2,
                                                              style:TextStyle(
                                                                fontSize: mqw*0.04,
                                                                color: Colors.black87,
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if(medCertsReqs[index].status == CertStatus.pending || medCertsReqs[index].status == CertStatus.none)
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context, 
                                                          builder: (BuildContext context)=>
                                                            BackdropFilter(
                                                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                              child: AlertDialog(

                                                                backgroundColor: Colors.red[300],
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(mqh*0.025),
                                                                ),
                                                                title: Text(
                                                                  "Are you sure to reject this certificate request?",
                                                                  style: TextStyle(
                                                                    fontSize: mqh*0.023,
                                                                    color:Colors.black,
                                                                  ),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                                contentPadding: EdgeInsets.zero,
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                          setState(() {
                                                                            medCertsReqs[index].status = CertStatus.rejected;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Yes",
                                                                          style: TextStyle(
                                                                            fontSize:mqh*0.022
                                                                          ),
                                                                        )
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Text(
                                                                          "No",
                                                                          style: TextStyle(
                                                                            fontSize:mqh*0.022
                                                                          ),
                                                                        )
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                        );
                                                      },
                                                      child: Container(      
                                                        padding: EdgeInsets.all(mqw*0.02),
                                                        width:mqw*0.382,
                                                        height: mqh*0.064757,
                                                        decoration: BoxDecoration(
                                                          color: Colors.red[400],
                                                          borderRadius: BorderRadius.only(
                                                            bottomLeft: Radius.circular(mqh*0.01),
                                                          )
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          "Reject",
                                                          textAlign: TextAlign.center,
                                                          style:TextStyle(
                                                            fontSize: mqw*0.04,
                                                            letterSpacing: 1.2,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          )
                                                        ),
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context, 
                                                          builder: (BuildContext context)=>
                                                            BackdropFilter(
                                                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                                              child: AlertDialog(
                                                                backgroundColor: Colors.green[300],
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(mqh*0.025),
                                                                ),
                                                                title: Text(
                                                                  "Are you sure to approve this certificate request?",
                                                                  style: TextStyle(
                                                                    fontSize: mqh*0.023,
                                                                    color:Colors.black,
                                                                  ),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                                contentPadding: EdgeInsets.zero,
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                          setState(() {
                                                                            medCertsReqs[index].status = CertStatus.approved;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Yes",
                                                                          style: TextStyle(
                                                                            fontSize:mqh*0.022
                                                                          ),
                                                                        )
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                        },
                                                                        child: Text(
                                                                          "No",
                                                                          style: TextStyle(
                                                                            fontSize:mqh*0.022
                                                                          ),
                                                                        )
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                        );
                                                      },
                                                      child: Container(  
                                                        padding: EdgeInsets.all(mqw*0.02),
                                                        width:mqw*0.382,
                                                        height: mqh*0.064757,
                                                        decoration: BoxDecoration(
                                                          color: Colors.green[400],
                                                          borderRadius: BorderRadius.only(
                                                              bottomRight: Radius.circular(mqh*0.01),
                                                          )
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          "Approve",
                                                          textAlign: TextAlign.center,
                                                          style:TextStyle(
                                                            fontSize: mqw*0.04,
                                                            letterSpacing: 1.2,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          )
                                                        ),
                                                      ),
                                                    )
                                                  ]
                                                ),
                                                if(medCertsReqs[index].status != CertStatus.pending && medCertsReqs[index].status != CertStatus.none)
                                                Row(
                                                  children: [
                                                    Container(      
                                                      padding: EdgeInsets.all(mqw*0.02),
                                                      width:mqw*0.764,
                                                      height: mqh*0.064757,
                                                      decoration: BoxDecoration(
                                                        color: 
                                                        (medCertsReqs[index].status==CertStatus.rejected)?Colors.red[400]:Colors.green[400],
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(mqh*0.01),
                                                          bottomRight: Radius.circular(mqh*0.01),
                                                        )
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        (medCertsReqs[index].status==CertStatus.rejected)?"Rejected":"Approved",
                                                        textAlign: TextAlign.center,
                                                        style:TextStyle(
                                                          fontSize: mqw*0.04,
                                                          letterSpacing: 1.2,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        )
                                                      ),
                                                    ),
                                                  ]
                                                ),
                                              ],
                                            ),
                                          )
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