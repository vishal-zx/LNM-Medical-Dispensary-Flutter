import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckAppointHistory extends StatefulWidget {
  const CheckAppointHistory({ Key? key }) : super(key: key);

  @override
  _CheckAppointHistoryState createState() => _CheckAppointHistoryState();
}

class Appointments{
  String doctor = "";
  String dateTime = "";
  bool isAppointUrgent = false;
  int isApproved = 2;
  String reason = "";

  Appointments(this.doctor, this.dateTime, this.isAppointUrgent, this.isApproved, this.reason);
}

class _CheckAppointHistoryState extends State<CheckAppointHistory> {
  final formKey = GlobalKey<FormState>();
  List<Appointments> appoints = [];
  bool load = false;
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');

  Future<void> getAppoints()async{
    DocumentSnapshot qs = await FirebaseFirestore.instance.collection('appointment').doc(username).get();
    var app = qs.data() as Map<String, dynamic>;
    List<dynamic> docs = app['docs']!;
    for(var i in docs){
      QuerySnapshot qs = await FirebaseFirestore.instance.collection('appointment').doc(username).collection(i.toString()).get();
      var apps = qs.docs;
      for(var ap in apps){
        var t = ap.data() as Map<String, dynamic>;
        QuerySnapshot qsD = await FirebaseFirestore.instance.collection('doctor').where('Username', isEqualTo:i.toString()).get();
        String dName = qsD.docs[0]['FirstName']!+" "+qsD.docs[0]['LastName']!;
        appoints.add(Appointments(dName, t['Timing']!, t['isUrgent']!, t['isApproved']!, t['Reason']!));
        setState(() {});
      }
    }
    setState(() {});
  }

  @override
  void initState(){
    if(appoints.isEmpty){
      getAppoints().whenComplete(() => setState((){load = true;}));
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
                      "View Appointments History",
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
                          child: Container(
                            padding: EdgeInsets.only(right:mqw*0.05),
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
                                    padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                                    width: mqw*0.84,
                                    height: mqh*0.755,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(), 
                                      itemCount: appoints.length,
                                      itemBuilder: (context, index){
                                        return SizedBox(
                                          height:mqh*0.14,
                                          child: Card(  
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(mqh*0.01)
                                            ),
                                            color: (appoints[index].isApproved==2)?Colors.orange[200]:(appoints[index].isApproved==0)?Colors.green[200]:Colors.red[200],
                                            child: Container(
                                              padding: EdgeInsets.all(mqw*0.02),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            size: mqh*0.025
                                                          ),
                                                          Text(
                                                            " Dr. "+appoints[index].doctor,
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.access_time,
                                                            size: mqh*0.025
                                                          ),
                                                          SizedBox(
                                                            width: mqw*0.015,
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                appoints[index].dateTime.substring(0,10),
                                                                textAlign: TextAlign.center,
                                                                style:TextStyle(
                                                                  fontSize: mqw*0.03,
                                                                  color: Colors.black87,
                                                                )
                                                              ),
                                                              Text(
                                                                appoints[index].dateTime.substring(11),
                                                                textAlign: TextAlign.center,
                                                                style:TextStyle(
                                                                  fontSize: mqw*0.03,
                                                                  color: Colors.black87,
                                                                )
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: mqh*0.015,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children:[
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Reason: ",
                                                            textAlign: TextAlign.left,
                                                            overflow: TextOverflow.ellipsis,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.035,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Text(
                                                            appoints[index].reason,
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.035,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Urgent Appointment: ",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.035,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Text(
                                                            (appoints[index].isAppointUrgent)?"Yes":"No",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.035,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                        ],
                                                      ),
                                                    ]
                                                  ),
                                                ],
                                              ),
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