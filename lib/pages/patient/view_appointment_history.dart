import 'dart:core';
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
  bool isApproved = false;
  String reason = "";

  Appointments(this.doctor, this.dateTime, this.isAppointUrgent, this.isApproved, this.reason);
}

class _CheckAppointHistoryState extends State<CheckAppointHistory> {
  final formKey = GlobalKey<FormState>();

  List<Appointments> appoints = [
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, false, 'fever fever fever fever fever fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, false, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, true, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, false, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, true, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, false, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), false, true, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy hh:mm a").format(DateTime.now()), true, true, 'fever'),
  ];

  @override
  void initState(){
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
                            child: SingleChildScrollView(
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
                                            color: (appoints[index].isApproved)?Colors.green[200]:Colors.red[200],
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
                                                                appoints[index].dateTime.substring(0,9),
                                                                textAlign: TextAlign.center,
                                                                style:TextStyle(
                                                                  fontSize: mqw*0.03,
                                                                  color: Colors.black87,
                                                                )
                                                              ),
                                                              Text(
                                                                appoints[index].dateTime.substring(9),
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