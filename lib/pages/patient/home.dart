import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lnm_medical_dispensary/pages/login.dart';
import 'package:lnm_medical_dispensary/pages/patient/book_appointment.dart';
import 'package:lnm_medical_dispensary/pages/patient/view_appointment_history.dart';
import 'package:page_transition/page_transition.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({ Key? key }) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  List<Map<String, Widget>> opts = [
      {'Book Appointment': const BookAppointment()},
      {'View Appointments History': const CheckAppointHistory()},
      {'Book A Test': const Login()},
      {'View Medical History': const Login()},
      {'Request Medical Certificate': const Login()},
      {'View Medical\nCertificates History': const Login()},
      {'Update Profile': const Login()},
      {'Submit Feedback': const Login()},
      {'Logout': const Login()},
  ];
  
  Future<bool> _exitApp() async {
    SystemNavigator.pop();
    return true;
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
                            color: Colors.amber[100],
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
                                    Navigator.push(
                                      context, 
                                      PageTransition(
                                        type: PageTransitionType.leftToRightJoined, 
                                        duration: const Duration(milliseconds: 400),
                                        child: opts[index].values.first,
                                        childCurrent: const PatientHome()
                                      )
                                    );
                                  },
                                  child: SizedBox(
                                    height:mqh*0.18,
                                    child: Card(  
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(mqh*0.01)),
                                      color: Colors.amberAccent[700],
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