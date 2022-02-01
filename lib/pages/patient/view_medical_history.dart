import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lnm_medical_dispensary/pages/patient/medical_record.dart';
import 'package:page_transition/page_transition.dart';
import '../doctor/view_pat_history.dart';

class ViewMedHis extends StatefulWidget {
  const ViewMedHis({ Key? key }) : super(key: key);

  @override
  _ViewMedHisState createState() => _ViewMedHisState();
}

class _ViewMedHisState extends State<ViewMedHis> {
  final formKey = GlobalKey<FormState>();
  bool hisLoaded = false;
  List<PatHistory> patHis = [];
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
  late PatDetails pd;
  
  Future<void> getPatHis() async{
    patHis.clear();
    DocumentSnapshot qs = await FirebaseFirestore.instance.collection('patientHistory').doc(username).get();
    var history = qs.data() as Map<String, dynamic>;
    history.forEach((key, value) async{
      QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo: username).get();
      String pName = qsP.docs[0]['FirstName']!+" "+qsP.docs[0]['LastName']!;
      pd = PatDetails(pName, qsP.docs[0]['Email'], qsP.docs[0]['Age'], qsP.docs[0]['Mob'], (qsP.docs[0]['isMale'])?"Male":"Female");
      QuerySnapshot qsD = await FirebaseFirestore.instance.collection('doctor').where('Username', isEqualTo:key).get();
      String dName = qsD.docs[0]['FirstName']!+" "+qsD.docs[0]['LastName']!;
      for(var i in value){
        var his = i as Map<String, dynamic>;
        patHis.add(
          PatHistory(dName, pName, his['Timing']!, his['Reason']!, his['Prescription']!, his['OtherIns']!, his['Refer']!)
        );
        setState(() {});
      }
    });
  }


  @override
  void initState(){
    if(patHis.isEmpty){
      getPatHis().then((value){
        setState(() {
          Future.delayed(const Duration(milliseconds: 500), (){
            hisLoaded = true;
          });
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
                      "View Medical History",
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
                            child: (!hisLoaded)?Center(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                                    width: mqw*0.84,
                                    height: mqh*0.74,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(), 
                                      itemCount: patHis.length,
                                      itemBuilder: (context, index){
                                        return GestureDetector(
                                          onTap:(){
                                            Navigator.push(
                                              context, 
                                              PageTransition(
                                                type: PageTransitionType.bottomToTop, 
                                                duration: const Duration(milliseconds: 400),
                                                child: MedRecord(patHis: patHis[index], patDetails: pd),
                                                childCurrent: const ViewMedHis()
                                              )
                                            );
                                          },
                                          child: SizedBox(
                                            child: Card(  
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(mqh*0.01)
                                              ),
                                              color: Colors.amber[300],
                                              child: Container(
                                                padding: EdgeInsets.all(mqw*0.02),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Doctor:",
                                                          textAlign: TextAlign.center,
                                                          style:TextStyle(
                                                            fontSize: mqw*0.04,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black87,
                                                          )
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            " Dr. "+ patHis[index].doctor,
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
                                                    SizedBox(
                                                      height:mqh*0.01
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Timing:",
                                                          textAlign: TextAlign.center,
                                                          style:TextStyle(
                                                            fontSize: mqw*0.04,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black87,
                                                          )
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            " "+ patHis[index].dateTime,
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
                                                    SizedBox(
                                                      height:mqh*0.01
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
                                                            patHis[index].reason,
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
                                                    SizedBox(
                                                      height:mqh*0.01
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Prescription:",
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
                                                            patHis[index].prescription,
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
                                            )
                                          ),
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