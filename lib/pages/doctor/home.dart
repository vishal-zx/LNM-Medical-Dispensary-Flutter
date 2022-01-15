import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lnm_medical_dispensary/pages/doctor/give_treatment.dart';
import 'package:lnm_medical_dispensary/pages/doctor/profile.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_appointments.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_feedbacks.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_medical_cert_request.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_pat_history.dart';
import 'package:page_transition/page_transition.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({ Key? key }) : super(key: key);

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

Widget logout(BuildContext context, double mqh){
  return BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
    child: AlertDialog(
      backgroundColor: Colors.cyan[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(mqh*0.025),
      ),
      title: Text(
        "Are you sure you want to logout?",
        style: TextStyle(
          fontSize: mqh*0.03,
          color:Colors.black,
        ),
      ),
      contentPadding: EdgeInsets.zero,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: (){
              },
              child: Text(
                "Logout",
                style: TextStyle(
                  fontSize:mqh*0.028
                ),
              )
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize:mqh*0.028
                ),
              )
            )
          ],
        )
      ]
    ),
  );
}

class _DoctorHomeState extends State<DoctorHome> {
  
  Future<bool> _exitApp() async {
    SystemNavigator.pop();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    List<Map<String, Widget>> opts = [
      {'New Treatment': const NewTreatment()},
      {'View Appointments': const ViewAppointsRequests()},
      {'View Patient History': const ViewPatHis()},
      {'View Medical\nCertificates Requests': const MedCertReqs()},
      {'Update Profile': const DoctorProfile()},
      {'View Feedbacks': const ViewFeedbacks()},
      {'Logout': logout(context, mqh)},
    ];
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
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          "Welcome to",
                          style:TextStyle(
                            fontSize: mqh*0.025,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )
                        ),
                        Text(
                          "LNM Medical Dispensary",
                          style:TextStyle(
                            fontSize: mqh*0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          )
                        ),
                      ],
                    )
                  ),
                  SizedBox(
                    height:mqh*0.02
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Stack(
                      clipBehavior: Clip.none, 
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.cyan[100],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(mqh*0.05),
                            )
                          ),
                          alignment: Alignment.bottomLeft,
                          width: mqw*0.9,
                          height: mqh*0.8,
                          child: Container(
                            padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                            width: mqw*0.84,
                            height: mqh*0.755,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(), 
                              itemCount: opts.length,
                              itemBuilder: (context, index){
                                return GestureDetector(
                                  onTap:(){
                                    if(index!=opts.length-1){
                                      Navigator.push(
                                        context, 
                                        PageTransition(
                                          type: PageTransitionType.leftToRightJoined, 
                                          duration: const Duration(milliseconds: 400),
                                          child: opts[index].values.first,
                                          childCurrent: const DoctorHome()
                                        )
                                      );
                                    }
                                    else{
                                      showDialog(
                                        context: context, 
                                        builder: (BuildContext context) => logout(context, mqh)
                                      );
                                    }
                                  },
                                  child: SizedBox(
                                    height:mqh*0.18,
                                    child: Card(  
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(mqh*0.01)),
                                      color: Colors.cyanAccent[700],
                                      child: Center(
                                        child: Text(
                                          opts[index].keys.first,
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                      ),
                                    )
                                  ),
                                );
                              }
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