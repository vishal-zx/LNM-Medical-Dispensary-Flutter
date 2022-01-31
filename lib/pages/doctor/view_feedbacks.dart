import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
  bool load = false;
  List<Feedback> feedback = [
  ];

  Future<void> getFeedbacks()async{
    feedback.clear();
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('feedback').doc(username).get();
    var data = snapshot.data() as Map<String, dynamic>;
    for(var fb in data['feedbacks']!){
      var db = fb as Map<String, dynamic>;
      feedback.add(Feedback(db['Patient']!, db['Feedback']!, db['Rating']!));
    }
    setState(() {});
  }

  @override
  void initState(){
    if(feedback.isEmpty){
      getFeedbacks().whenComplete(() => setState((){load = true;}));
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
                                                      SizedBox(
                                                        height:mqh*0.01
                                                      ),
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Text(
                                                            "Rated:",
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
                                                              const Icon(Icons.star, color: Colors.black, size: 18),
                                                              for(var i=feedback[index].star;i<5;i++)
                                                              Icon(Icons.star_border, color: Colors.black.withAlpha(200), size: 18),
                                                            ],
                                                          ),
                                                          Text(
                                                            "   (${feedback[index].star}/5)",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqw*0.033,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black87,
                                                            )
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