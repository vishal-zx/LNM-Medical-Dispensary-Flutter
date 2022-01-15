import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


class ViewFeedbacks extends StatefulWidget {
  const ViewFeedbacks({ Key? key }) : super(key: key);

  @override
  _ViewFeedbacksState createState() => _ViewFeedbacksState();
}

class Feedback{
  String patient = "";
  String feedback = "";
  num star;

  Feedback(this.patient, this.feedback, this.star);
}

class _ViewFeedbacksState extends State<ViewFeedbacks> {
  final formKey = GlobalKey<FormState>();
  List<bool> stars = [];

  List<Feedback> feedback = [
      Feedback('Vishal Gupta', 'fever fever fever fever fever fever in order to open APK files, your application needs', 5),
      Feedback('Chand Singh', 'fever', 4),
      Feedback('Amit Malhotra', 'fever', 2),
      Feedback('Nidhi Bisht', 'fever', 3),
      Feedback('Vishal Gupta', 'fever', 1),
      Feedback('Chand Singh', 'fever', 3),
      Feedback('Amit Malhotra', 'fever in order to open APK files, your application needs', 5),
      Feedback('Nidhi Bisht', 'fever', 2),
      Feedback('Vishal Gupta', 'fever', 3),
      Feedback('Chand Singh', 'fever', 3),
      Feedback('Amit Malhotra', 'fever', 1),
      Feedback('Nidhi Bisht', 'fever', 1),
      Feedback('Vishal Gupta', 'fever', 4),
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
                      "View Feedbacks",
                      style:TextStyle(
                        fontSize: mqh*0.044,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )
                    )
                  ),
                  SizedBox(
                    height:mqh*0.02
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
                                      itemCount: feedback.length,
                                      itemBuilder: (context, index){
                                        return SizedBox(
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
                                                            "Name:",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              " "+ feedback[index].patient,
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
                                                            "Feedback:",
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
                                                              feedback[index].feedback,
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              softWrap:false,
                                                              maxLines: 5,
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
                                                            "Rating:",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.04,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              const Text(" "),
                                                              for(var i=0;i<feedback[index].star;i++)
                                                              const Icon(Icons.star, color: Colors.black),
                                                              for(var i=feedback[index].star;i<5;i++)
                                                              Icon(Icons.star_border, color: Colors.black.withAlpha(200)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
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