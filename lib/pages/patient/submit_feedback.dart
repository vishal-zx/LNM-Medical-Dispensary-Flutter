import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class SubmitFeedback extends StatefulWidget {
  const SubmitFeedback({ Key? key }) : super(key: key);

  @override
  _SubmitFeedbackState createState() => _SubmitFeedbackState();
}

class _SubmitFeedbackState extends State<SubmitFeedback> {
  final formKey = GlobalKey<FormState>();

  bool _check1 = false; 
  bool dataLoaded = false;
  String pName = "";

  List<DropdownMenuItem<String>> dropDownDocs = [];

  Future<void> getDoctors() async{
    
    QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo:username).get();
    var d = qsP.docs[0].data() as Map<String, dynamic>;
    pName = d['FirstName'] + " " + d['LastName'];  
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('doctor').orderBy('FirstName').get();
    var doctors = qs.docs;
    for(var doc in doctors){
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if(data.containsKey('Username')){
        dropDownDocs.add(DropdownMenuItem(
          child: Text("Dr. ${data['FirstName']} ${data['LastName']}"),
          value: data['Username'],
        ));
      }
    }
    setState(() {});
  }

  SnackBar snackBar(String text){
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return SnackBar(
      duration: const Duration(milliseconds:3500),
      content: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(
          fontSize: mqh*0.0225,
          fontFamily: 'Avenir',
          color: Colors.white
        ),
      ),
      backgroundColor: Colors.black,
      elevation: 5,
      width: mqw*0.8,
      behavior: SnackBarBehavior.floating,
      padding: EdgeInsets.all(mqw*0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(mqw*0.04))
      ),
    );
  }
  
  String selectedDoc = "";
  String feedback = "";
  List<bool> stars = [true, false, false, false, false];
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
  
  @override
  void initState(){
    if(dropDownDocs.isEmpty){
      getDoctors().whenComplete(() => setState(() => dataLoaded = true));
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
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left:mqw*0.11),
                    child: Text(
                      "Submit Feedback",
                      style:TextStyle(
                        fontSize: mqh*0.045,
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
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(mqh*0.05),
                            )
                          ),
                          alignment: Alignment.bottomRight,
                          width: mqw*0.9,
                          height: mqh*0.8,
                          child: Container(
                            padding: EdgeInsets.only(left:mqw*0.02, right:mqw*0.07),
                            width: mqw*0.84,
                            height: mqh*0.755,
                            child: Form(
                              key: formKey,
                              child: (!dataLoaded)?Center(
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text(
                                      "Doctor",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    SearchChoices.single(
                                      items: dropDownDocs,
                                      value: selectedDoc,
                                      hint: "Select one",
                                      searchHint: null,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDoc = value;
                                          feedback = "";
                                          stars = [true, false, false, false, false];
                                        });
                                      },
                                      onClear: (){
                                        setState(() {
                                          selectedDoc = "";
                                          feedback = "";
                                          stars = [true, false, false, false, false];
                                        });
                                      },
                                      style:TextStyle(
                                        fontSize: mqh*0.025,
                                        color: Colors.black,
                                        fontFamily: 'Avenir'
                                      ),
                                      menuBackgroundColor: Colors.amberAccent[100],
                                      dialogBox: true,
                                      isExpanded: true,
                                    ),
                                    SizedBox(
                                      height:mqh*0.04
                                    ),
                                    if(selectedDoc!="")
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Rate Doctor",
                                          style:TextStyle(
                                            fontSize: mqh*0.035,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            for(var i=0;i<5;i++)
                                            IconButton(
                                              icon: stars[i]?Icon(Icons.star, color: Colors.amber.shade800):Icon(Icons.star_border, color: Colors.black.withAlpha(200)),
                                              iconSize: mqh*0.052,
                                              onPressed: () {
                                                setState(() {
                                                  for(var j=0;j<=i;j++){
                                                    stars[j] = true;
                                                  }
                                                  for(var j=i+1;j<5;j++){
                                                    stars[j] = false;
                                                  }
                                                });
                                              }
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height:mqh*0.03
                                        ),
                                        Text(
                                          "Comment",
                                          style:TextStyle(
                                            fontSize: mqh*0.035,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height:mqh*0.01
                                        ),
                                        TextFormField(
                                          decoration: const InputDecoration(
                                            hintText: "Enter your honest feedback",
                                          ),
                                          maxLength: 200,
                                          maxLines: 5,
                                          minLines: 1,
                                          onChanged:(value){
                                            feedback = value;
                                          },
                                        ),
                                        SizedBox(
                                          height:mqh*0.05
                                        ),
                                      ],
                                    ),
                                    
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (selectedDoc!="")?(_check1 == true)?Colors.orange[300]:Colors.orange:Colors.grey,
                                        borderRadius: BorderRadius.circular(_check1?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: ()async {
                                            if(selectedDoc!=""){
                                              if(feedback==""){
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar('Provide some feedback!'));
                                              }
                                              else{
                                                print(FirebaseAuth.instance.currentUser!.displayName);
                                                var ii=0;
                                                for(var i=0;i<stars.length;i++){
                                                  if(stars[i]){
                                                    ii++;
                                                  }
                                                }
                                                setState((){
                                                  _check1 = !_check1;
                                                });
                                                await FirebaseFirestore.instance.collection('feedback').doc(selectedDoc).update({
                                                  'feedbacks': FieldValue.arrayUnion([
                                                    {
                                                      'Feedback' : feedback,
                                                      'Patient' : pName,
                                                      'Rating': ii,
                                                    }
                                                  ])
                                                }).whenComplete(() {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar('Feedback submitted successfully!!'));
                                                });
                                              }
                                            }
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(seconds: 1),
                                            width: _check1?mqw*0.125: mqw*0.3,
                                            height: mqw*0.125,
                                            alignment: Alignment.center,
                                            child: _check1?
                                            const Icon(
                                              Icons.done, color: Colors.white,
                                            ) :
                                            Text(
                                              "Submit",
                                              style: TextStyle(
                                                color: Colors.white, 
                                                fontWeight: FontWeight.bold,
                                                fontSize: mqh*0.025,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height:mqh*0.025
                                    ),
                                  ]
                                )
                              ),
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