import 'dart:core';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lnm_medical_dispensary/pages/doctor/give_treatment.dart';
import 'package:lnm_medical_dispensary/pages/doctor/profile.dart';
import 'package:lnm_medical_dispensary/pages/doctor/update_schedule.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_appointments.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_feedbacks.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_medical_cert_request.dart';
import 'package:lnm_medical_dispensary/pages/doctor/view_pat_history.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../login.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({ Key? key }) : super(key: key);

  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

Widget logout(BuildContext context, double mqh, double mqw){
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
              onPressed: ()async{
                showDialog(
                  barrierDismissible: false,
                  context: context, 
                  builder: (BuildContext context) {
                    return WillPopScope(
                      onWillPop: () async => false,
                      child: AlertDialog(
                        backgroundColor: Colors.cyan.shade100,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mqw*0.03)),
                        insetPadding: EdgeInsets.only(left:mqw*0.15),
                        content: Container(
                          alignment: Alignment.center,
                          width:mqw*0.5,
                          height:mqh*0.25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height:mqw*0.1,
                                width:mqw*0.1,
                                child: const CircularProgressIndicator(
                                  color: Colors.cyan,
                                ),
                              ),
                              SizedBox(
                                height:mqh*0.035,
                              ),
                              Text(
                                "Signing out..\nPlease wait..",
                                textAlign: TextAlign.center,
                                style:TextStyle(
                                  fontSize: mqh*0.02,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
                await FirebaseAuth.instance.signOut().then((value) async{
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft, 
                        duration: const Duration(milliseconds: 400),
                        child: const Login(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  });
                });
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
    Navigator.pop(context,true);
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
      {'Update Schedule': const UpdateSchedule()},
      {'Update Profile': const DoctorProfile()},
      {'View Feedbacks': const ViewFeedbacks()},
      {'Logout': logout(context, mqh, mqw)},
    ];
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.cyan[300],
        body: SafeArea(
          child: WillPopScope(
            onWillPop: _exitApp,
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
                                            type: PageTransitionType.leftToRight, 
                                            duration: const Duration(milliseconds: 400),
                                            child: opts[index].values.first,
                                            childCurrent: const DoctorHome()
                                          )
                                        );
                                      }
                                      else{
                                        showDialog(
                                          context: context, 
                                          builder: (BuildContext context) => logout(context, mqh, mqw)
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
          ),
        )
      ),
    );
  }
}