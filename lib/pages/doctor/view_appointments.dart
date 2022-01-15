import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class ViewAppointsRequests extends StatefulWidget {
  const ViewAppointsRequests({ Key? key }) : super(key: key);

  @override
  _ViewAppointsRequestsState createState() => _ViewAppointsRequestsState();
}

class Appointments{
  String patient = "";
  String dateTime = "";
  bool isAppointUrgent = false;
  var status = 2;
  String reason = "";

  Appointments(this.patient, this.dateTime, this.isAppointUrgent, this.status, this.reason);
}

class _ViewAppointsRequestsState extends State<ViewAppointsRequests> {
  final formKey = GlobalKey<FormState>();

  List<Appointments> appoints = [
      Appointments('Vishal Gupta ', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever fever fever fever fever fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever fever fever fever fever fever fever fever fever fever fever fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Vishal Gupta', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Chand Singh', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
      Appointments('Amit Malhotra', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), false, 2, 'fever'),
      Appointments('Nidhi Bisht', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), true, 2, 'fever'),
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
                      "View Appointments Requests",
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
                                          height:mqh*0.22,
                                          child: Card(  
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(mqh*0.01)
                                            ),
                                            color: Colors.cyan.shade300,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(      
                                                      padding: EdgeInsets.all(mqw*0.03),
                                                      width:mqw*0.565,
                                                      height: mqh*0.145,
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
                                                                  " "+ appoints[index].patient,
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
                                                                  " "+ appoints[index].dateTime,
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
                                                                  appoints[index].reason,
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
                                                    if(appoints[index].isAppointUrgent)
                                                    Container(  
                                                      padding: EdgeInsets.all(mqw*0.02),
                                                      width:mqw*0.154,
                                                      height: mqh*0.145,
                                                      decoration: BoxDecoration(
                                                        color: Colors.yellow[400],
                                                        borderRadius: BorderRadius.only(
                                                            topRight: Radius.circular(mqh*0.01),
                                                        )
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: RotatedBox(
                                                        quarterTurns: 3,
                                                        child: Text(
                                                          (appoints[index].isAppointUrgent)?"Urgent":"",
                                                          textAlign: TextAlign.center,
                                                          style:TextStyle(
                                                            fontSize: mqw*0.06,
                                                            letterSpacing: 1.2,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.black,
                                                          )
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    if(appoints[index].status!=0 && appoints[index].status==2)
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
                                                                title: const Text("Are you sure you want to reject this appointment request?"),
                                                                contentPadding: EdgeInsets.zero,
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                          setState(() {
                                                                            appoints[index].status = 1;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Yes",
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
                                                                          "No",
                                                                          style: TextStyle(
                                                                            fontSize:mqh*0.028
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
                                                        width:mqw*0.3595,
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
                                                    if(appoints[index].status!=1 && appoints[index].status==2)
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
                                                                title: const Text("Are you sure you want to approve this appointment request?"),
                                                                contentPadding: EdgeInsets.zero,
                                                                actions: [
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: (){
                                                                          Navigator.of(context).pop();
                                                                          setState(() {
                                                                            appoints[index].status = 0;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Yes",
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
                                                                          "No",
                                                                          style: TextStyle(
                                                                            fontSize:mqh*0.028
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
                                                        width:mqw*0.3595,
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
                                                if(appoints[index].status!=2)
                                                Row(
                                                  children: [
                                                    Container(      
                                                      padding: EdgeInsets.all(mqw*0.02),
                                                      width:mqw*0.719,
                                                      height: mqh*0.064757,
                                                      decoration: BoxDecoration(
                                                        color: (appoints[index].status==1)?Colors.red[400]:Colors.green[400],
                                                        borderRadius: BorderRadius.only(
                                                          bottomLeft: Radius.circular(mqh*0.01),
                                                        )
                                                      ),
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        (appoints[index].status==1)?"Rejected":"Approved",
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