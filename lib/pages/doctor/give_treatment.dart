import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class NewTreatment extends StatefulWidget {
  const NewTreatment({ Key? key }) : super(key: key);

  @override
  _NewTreatmentState createState() => _NewTreatmentState();
}

class _NewTreatmentState extends State<NewTreatment> {
  final formKey = GlobalKey<FormState>();
  bool _check1 = false; 
  String currentDoc = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
  String time = '';

  List<DropdownMenuItem<String>> dropDownPats = [];
  List<DropdownMenuItem<String>> dropDownApps = [];
  Map<String, String> timeReasons = {};

  SnackBar snackBar(String text){
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return SnackBar(
      duration: const Duration(milliseconds:3500),
      content: Text(
        text, 
        textAlign: TextAlign.center, 
        style: TextStyle(
          fontSize: mqh*0.02,
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

  Future<void> getPatients() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('appointment').get();
    var patUsernames = qs.docs;
    for(var pat in patUsernames){
      QuerySnapshot q = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo: pat.id).get();
      Map<String, dynamic> data = q.docs.first.data() as Map<String, dynamic>;
      String fName = data['FirstName'];
      String lName = data['LastName'];
      dropDownPats.add(DropdownMenuItem(
        child: Text("$fName $lName"),
        value: pat.id,
      ));
    }
  }
  Future<void> getAppoints(String pat) async{
    dropDownApps.clear();
    String doc = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('appointment').doc(pat).collection(doc).get();
    var appoints = qs.docs;
    for(var app in appoints){
      Map<String, dynamic> data = app.data() as Map<String, dynamic>;
      String timing = data['Timing'];
      String reason = data['Reason'];
      int isApproved = data['isApproved'];
      if(isApproved == 0){
        dropDownApps.add(DropdownMenuItem(
          child: Text(
            "Date: ${timing.substring(0,10)}   Time: ${timing.substring(11)}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          value: reason,
        ));
        setState(() {
          timeReasons.addAll({reason: timing});
        });
      }
    }
  }
  
  String selectedPatValue = "";
  String selectedAppValue = "";
  String prescription = "";
  String reason = "";
  String instructions = "";
  bool dataLoadedPat = false;
  bool dataLoadedApp = false;
  String referTo = "";

  @override
  void initState(){
    if(dropDownPats.isEmpty){
      getPatients().then((value){
        setState(() {
          dataLoadedPat = true;
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
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left:mqw*0.09),
                    child: Text(
                      "New Treatment",
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
                            color: Colors.cyan[100],
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
                              child: (!dataLoadedPat)?Center(
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
                                physics: const BouncingScrollPhysics(), 
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text(
                                      "Patient",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    SearchChoices.single(
                                      items: dropDownPats,
                                      searchInputDecoration: const InputDecoration(
                                        labelText: "Search by typing email..."
                                      ),
                                      value: selectedPatValue,
                                      onClear: (){
                                        setState(() {
                                          selectedPatValue = "";
                                          selectedAppValue = "";
                                        });
                                      },
                                      style:TextStyle(
                                        fontSize: mqh*0.022,
                                        color: Colors.black,
                                        fontFamily: 'Avenir'
                                      ),
                                      hint: "Select one",
                                      searchHint: null,
                                      onChanged: (value) async{
                                        setState(() {
                                          selectedPatValue = value;
                                          selectedAppValue = '';
                                          reason='';
                                          prescription = '';
                                          instructions = '';
                                          referTo = '';
                                          getAppoints(selectedPatValue);
                                        });
                                      },
                                      menuBackgroundColor: Colors.cyan[100],
                                      dialogBox: true,
                                      isExpanded: true,
                                    ),
                                    SizedBox(
                                      height:mqh*0.03
                                    ),
                                    if(selectedPatValue != "")
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Appointment Timing",
                                          style:TextStyle(
                                            fontSize: mqh*0.035,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SearchChoices.single(
                                          items: dropDownApps,
                                          value: selectedAppValue,
                                          searchInputDecoration: const InputDecoration(
                                            labelText: "Search by typing date..."
                                          ),
                                          style:TextStyle(
                                            fontSize: mqh*0.018,
                                            color: Colors.black,
                                            fontFamily: 'Avenir'
                                          ),
                                          hint: (dropDownApps.isEmpty)?"No Approved Appointments":"Select a approved appointment",
                                          searchHint: null,
                                          onClear: (){
                                            setState(() {
                                              selectedAppValue = '';
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              selectedAppValue = value;
                                              reason = selectedAppValue;
                                              time = timeReasons[reason]!.replaceAll('Date: ', '').replaceAll('Time: ','');
                                            });
                                          },
                                          menuBackgroundColor: Colors.cyan[100],
                                          dialogBox: true,
                                          isExpanded: true,
                                        ),
                                        SizedBox(
                                          height:mqh*0.03
                                        ),
                                        if(selectedAppValue!='')
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Reason",
                                              style:TextStyle(
                                                fontSize: mqh*0.035,
                                                color: Colors.black87,
                                              )
                                            ),
                                            Text(
                                              "(provided by patient)",
                                              style:TextStyle(
                                                fontSize: mqh*0.017,
                                                color: Colors.black87,
                                              )
                                            ),
                                            TextFormField(
                                              controller: TextEditingController()..text = reason,
                                              readOnly:true,
                                              minLines: 1,
                                              maxLines: 3,
                                              style:TextStyle(
                                                fontSize: mqh*0.018,
                                                color: Colors.black,
                                                fontFamily: 'Avenir'
                                              ),
                                            ),
                                            SizedBox(
                                              height:mqh*0.04
                                            ),
                                            Text(
                                              "Prescription",
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
                                                hintText: "Enter prescription",
                                              ),
                                              maxLength: 200,
                                              minLines: 1,
                                              maxLines: 5,
                                              onChanged:(value){
                                                prescription = value;
                                              },
                                            ),
                                            SizedBox(
                                              height:mqh*0.03
                                            ),
                                            Text(
                                              "Other Instructions",
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
                                                hintText: "Enter other instructions",
                                              ),
                                              maxLength: 100,
                                              minLines: 1,
                                              maxLines: 5,
                                              onChanged:(value){
                                                instructions = value;
                                              },
                                            ),
                                            SizedBox(
                                              height:mqh*0.03
                                            ),
                                            Text(
                                              "Refer to",
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
                                                hintText: "Refer to a doctor or a hospital",
                                              ),
                                              maxLength: 100,
                                              minLines: 1,
                                              maxLines: 5,
                                              onChanged:(value){
                                                referTo = value;
                                              },
                                            ),
                                            SizedBox(
                                              height:mqh*0.03
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (selectedPatValue=='' || selectedAppValue=='')?Colors.grey:
                                        ((_check1 == true)?Colors.blue[300]:Colors.blue),
                                        borderRadius: BorderRadius.circular(_check1?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: () async{
                                            if(selectedPatValue!='' && selectedAppValue!=''){
                                              if(prescription!=''){
                                                setState((){
                                                  _check1 = !_check1;
                                                });
                                                List<Map<String, String>> treatment = [{
                                                  'OtherIns': instructions,
                                                  'Prescription' : prescription,
                                                  'Reason' : reason,
                                                  'Timing': time,
                                                  'Refer' : referTo,
                                                }];
                                                await FirebaseFirestore.instance.collection('patientHistory').doc(selectedPatValue).set({
                                                  currentDoc: FieldValue.arrayUnion(treatment),
                                                },SetOptions(merge: true)).whenComplete(() {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar('Prescription created successfully!'));
                                                });
                                              }else{  
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar('Please provide some prescription!'));
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