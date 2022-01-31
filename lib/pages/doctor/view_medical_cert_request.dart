import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MedCertReqs extends StatefulWidget {
  const MedCertReqs({ Key? key }) : super(key: key);

  @override
  _MedCertReqsState createState() => _MedCertReqsState();
}

class MedCertRequests{
  String mcId = "";
  String pId = "";
  String patient = "";
  String doctor = "";
  String fromDate = DateTime.now().toString();
  String toDate = DateTime.now().toString();
  int status = 2;
  String reason = "";

  MedCertRequests(this.mcId, this.pId, this.patient, this.doctor, this.fromDate, this.toDate, this.status, this.reason);
}

class _MedCertReqsState extends State<MedCertReqs> {
  final formKey = GlobalKey<FormState>();
  List<MedCertRequests> medCertsReqs = [];
  bool dataLoaded = false;
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');

  Future<void> getMedCertRequests() async{
    medCertsReqs.clear();
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('medicalCertificate').get();
    for(var pats in qs.docs){
      QuerySnapshot qsD = await FirebaseFirestore.instance.collection('medicalCertificate').doc(pats.id).collection(username).get();
      QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo:pats.id).get();
      String pName = qsP.docs[0]['FirstName']!+" "+qsP.docs[0]['LastName']!;
      QuerySnapshot qsDd = await FirebaseFirestore.instance.collection('doctor').where('Username', isEqualTo:username).get();
      String dName = qsDd.docs[0]['FirstName']!+" "+qsDd.docs[0]['LastName']!;
      for(var t in qsD.docs){
        Map<String, dynamic> data = t.data() as Map<String, dynamic>;
        medCertsReqs.add(MedCertRequests(
          t.id,
          pats.id,
          pName,
          dName,
          data['dateFrom']!,
          data['dateTo']!,
          data['isApproved']!,
          data['Reason']!,
        ));
      }
      setState(() {});
    }
  }

  @override
  void initState(){
    if(medCertsReqs.isEmpty){
      getMedCertRequests().then((value){
        setState(() {
          dataLoaded = true;
        });
      });
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
                            child: (!dataLoaded)?Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:mqw*0.1,
                                    width:mqw*0.1,
                                    child: CircularProgressIndicator(
                                      color: Colors.cyan.shade800,
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
                                    padding: EdgeInsets.only(left:mqw*0.035, right:mqw*0.02),
                                    width: mqw*0.84,
                                    height: mqh*0.755,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(), 
                                      itemCount: medCertsReqs.length,
                                      itemBuilder: (context, index){
                                        return SizedBox(
                                          height:mqh*0.26,
                                          child: Card(  
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(mqh*0.01)
                                            ),
                                            color: Colors.cyan.shade300,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Container(      
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
                                                              "Certificate Request From:",
                                                              textAlign: TextAlign.center,
                                                              style:TextStyle(
                                                                fontSize: mqw*0.04,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black87,
                                                              )
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                " "+ medCertsReqs[index].fromDate,
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
                                                              "Certificate Request To:",
                                                              textAlign: TextAlign.center,
                                                              style:TextStyle(
                                                                fontSize: mqw*0.04,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black87,
                                                              )
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                " "+ medCertsReqs[index].toDate,
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
                                                                maxLines: 3,
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
                                                ),
                                                if(medCertsReqs[index].status == 2)
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: GestureDetector(
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
                                                                          onPressed: ()async{
                                                                            Navigator.of(context).pop();
                                                                            await FirebaseFirestore.instance.collection('medicalCertificate').doc(medCertsReqs[index].pId)
                                                                            .collection(username).doc(medCertsReqs[index].mcId).update({
                                                                              'isApproved': 1,
                                                                            }).whenComplete(() => {
                                                                              setState(() {
                                                                                medCertsReqs[index].status = 1;
                                                                              }),
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
                                                    ),
                                                    Expanded(
                                                      child: GestureDetector(
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
                                                                          onPressed: ()async{
                                                                            Navigator.of(context).pop();
                                                                            await FirebaseFirestore.instance.collection('medicalCertificate').doc(medCertsReqs[index].pId)
                                                                            .collection(username).doc(medCertsReqs[index].mcId).update({
                                                                              'isApproved': 0,
                                                                            }).whenComplete(() => {
                                                                              setState(() {
                                                                                medCertsReqs[index].status = 0;
                                                                              }),
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
                                                      ),
                                                    )
                                                  ]
                                                ),
                                                if(medCertsReqs[index].status != 2)
                                                Row(
                                                  children: [
                                                    Container(      
                                                      padding: EdgeInsets.all(mqw*0.02),
                                                      width:mqw*0.764,
                                                      height: mqh*0.064757,
                                                      decoration: BoxDecoration(
                                                        color: 
                                                        (medCertsReqs[index].status==1)?Colors.red[400]:Colors.green[400],
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(mqh*0.01),
                                                          bottomRight: Radius.circular(mqh*0.01),
                                                        )
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        (medCertsReqs[index].status==1)?"Rejected":"Approved",
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