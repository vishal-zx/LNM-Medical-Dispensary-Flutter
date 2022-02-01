import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../apis/medcert_pdf_api.dart';
import '../../apis/pdf_api.dart';
import '../../models/model.dart';
import '../doctor/view_pat_history.dart';

class ViewMedCertReqs extends StatefulWidget {
  const ViewMedCertReqs({ Key? key }) : super(key: key);

  @override
  _ViewMedCertReqsState createState() => _ViewMedCertReqsState();
}

class MedCertRequests{
  String doctor = "";
  String fromDate = "";
  String toDate = "";
  int status = 2;
  String reason = "";

  MedCertRequests(this.doctor, this.fromDate, this.toDate, this.status, this.reason);
}

class _ViewMedCertReqsState extends State<ViewMedCertReqs> {
  final formKey = GlobalKey<FormState>();
  List<MedCertRequests> medCertsReqs = [];
  bool load = false;
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
  late PatDetails pd;

  Future<void> getMedCerts()async{
    QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo: username).get();
    String pName = qsP.docs[0]['FirstName']!+" "+qsP.docs[0]['LastName']!;
    pd = PatDetails(pName, qsP.docs[0]['Email'], qsP.docs[0]['Age'], qsP.docs[0]['Mob'], (qsP.docs[0]['isMale'])?"Male":"Female");
    
    DocumentSnapshot qs = await FirebaseFirestore.instance.collection('medicalCertificate').doc(username).get();
    var app = qs.data() as Map<String, dynamic>;
    List<dynamic> docs = app['docs']!;
    for(var i in docs){
      QuerySnapshot qs = await FirebaseFirestore.instance.collection('medicalCertificate').doc(username).collection(i.toString()).get();
      var apps = qs.docs;
      for(var ap in apps){
        var t = ap.data() as Map<String, dynamic>;
        QuerySnapshot qsD = await FirebaseFirestore.instance.collection('doctor').where('Username', isEqualTo:i.toString()).get();
        String dName = qsD.docs[0]['FirstName']!+" "+qsD.docs[0]['LastName']!;
        medCertsReqs.add(MedCertRequests(dName, t['dateFrom']!, t['dateTo']!, t['isApproved']!, t['Reason']!));
        setState(() {});
      }
    }
    setState(() {});
  }

  void buildMedCert(MedCertRequests medCert, PatDetails patDetails) async {
    var medCertRec = MedCert(
      medCert: medCert, 
      patDetails: patDetails
    );

    final pdfFile = await PdfMedCertApi.generate(medCertRec);
    PdfApi.openFile(pdfFile);
  }

  @override
  void initState(){
    if(medCertsReqs.isEmpty){
      getMedCerts().whenComplete(() => setState((){load = true;}));
    }
    super.initState();
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
                            child: (!load)?Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:mqw*0.1,
                                    width:mqw*0.1,
                                    child: CircularProgressIndicator(
                                      color: Colors.amber.shade800,
                                    ),
                                  ),
                                  SizedBox(
                                    height:mqh*0.035,
                                  ),
                                  Text(
                                    "Loading Data ...",
                                    textAlign: TextAlign.center,
                                    style:TextStyle(
                                      fontSize: mqh*0.02,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ):
                            SingleChildScrollView(
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
                                                                            medCertsReqs[index].fromDate.substring(0,8),
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
                                                                            medCertsReqs[index].toDate.substring(0,8),
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
                                                        backgroundColor: (medCertsReqs[index].status == 0)?Colors.green[200]:
                                                          (medCertsReqs[index].status == 0)?Colors.red[200]:Colors.orange[200],
                                                        title: Text(
                                                          'Request : '+((medCertsReqs[index].status == 0)?" Approved":
                                                          (medCertsReqs[index].status == 1)?" Rejected":" Pending"),
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: mqw*0.05,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        titlePadding: EdgeInsets.only(top: mqh*0.02),
                                                        contentPadding: EdgeInsets.zero,
                                                        actionsPadding: (medCertsReqs[index].status == 0)?EdgeInsets.zero:EdgeInsets.only(bottom: mqh*0.015),
                                                        actionsAlignment: MainAxisAlignment.center,
                                                        actions: <Widget>[
                                                          if(medCertsReqs[index].status == 0)
                                                            TextButton(
                                                            child: Text(
                                                              "View Medical Certificate",
                                                              style: TextStyle(
                                                                fontSize: mqw*0.045,
                                                                color: Colors.black,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            onPressed: () {
                                                              buildMedCert(medCertsReqs[index], pd);
                                                            },
                                                          ),
                                                          if(medCertsReqs[index].status == 2)
                                                            Text(
                                                              "Your request is still pending !",
                                                              style: TextStyle(
                                                                fontSize: mqw*0.045,
                                                                color: Colors.black,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                          if(medCertsReqs[index].status == 1)
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
                                                  color: (medCertsReqs[index].status == 0)?Colors.green[400]:
                                                          (medCertsReqs[index].status == 1)?Colors.red[400]:Colors.orange[400],
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: RotatedBox(
                                                      quarterTurns: 3,
                                                      child: Text(
                                                        (medCertsReqs[index].status == 0)?" Approved":
                                                        (medCertsReqs[index].status == 1)?" Rejected":" Pending",
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