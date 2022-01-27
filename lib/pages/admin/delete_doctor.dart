import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class DeleteDoctor extends StatefulWidget {
  const DeleteDoctor({ Key? key }) : super(key: key);

  @override
  _DeleteDoctorState createState() => _DeleteDoctorState();
}

class _DeleteDoctorState extends State<DeleteDoctor> {

  List<DropdownMenuItem<String>> doctors = [];
  
  String selectedValue = "";
  bool isDoctorSelected = false;
  final _check1 = false; 
  final _check = false;

  Future<void> getDoctors() async {
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('doctor').get();
    for(var ad in qs.docs){
      Map<String, dynamic> data = ad.data() as Map<String, dynamic>;
      doctors.add(DropdownMenuItem(child: Text(data['Email']), value: data['Email'])); 
    }
  }

  @override
  void initState(){
    super.initState();
    getDoctors().whenComplete(() => setState((){}));
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.red[300],
        body: SafeArea(
          child: SingleChildScrollView(
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
                      "Delete Doctor",
                      style:TextStyle(
                        fontSize: mqh*0.044,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )
                    )
                  ),
                  SizedBox(
                    height:mqh*0.025
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Stack(
                      clipBehavior: Clip.none, 
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(mqh*0.05),
                            )
                          ),
                          alignment: Alignment.center,
                          width: mqw*0.9,
                          height: mqh*0.8,
                          child: (doctors.isEmpty)?
                            Column(
                              children: [
                                SizedBox(
                                  height:mqh*0.2,
                                ),
                                SizedBox(
                                  height:mqw*0.1,
                                  width:mqw*0.1,
                                  child: const CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                ),
                                SizedBox(
                                  height:mqh*0.025,
                                ),
                                Text(
                                  "Please wait while we load data for you..",
                                  style: TextStyle(
                                    fontSize: mqh*0.02,
                                    color:Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ):
                            Container(
                            padding: EdgeInsets.only(right:mqw*0.05),
                            width: mqw*0.88,
                            height: mqh*0.755,
                            child: SingleChildScrollView(
                              child: Column(
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(right:mqw*0.04, left:mqw*0.09, top:mqh*0.02),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Select Doctor",
                                          style:TextStyle(
                                            fontSize: mqh*0.035,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SearchChoices.single(
                                          items: doctors,
                                          value: selectedValue,
                                          hint: "Select one",
                                          searchHint: null,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                              isDoctorSelected = true;
                                            });
                                          },
                                          style:TextStyle(
                                            fontSize: mqh*0.025,
                                            color: Colors.black,
                                            fontFamily: 'Avenir'
                                          ),
                                          menuBackgroundColor: Colors.red[100],
                                          dialogBox: true,
                                          isExpanded: true,
                                          onClear: (){
                                            setState(() { 
                                              isDoctorSelected = false;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(isDoctorSelected)
                                  Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(mqw*0.02),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                                " "+ selectedValue,
                                                textAlign: TextAlign.center,
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
                                      ),      
                                      SizedBox(
                                        height:mqh*0.015,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Material(
                                          color: (_check1 == true)?Colors.red[300]:Colors.red,
                                          borderRadius: BorderRadius.circular(_check?mqw*0.1:mqw*0.03),
                                          child: InkWell(
                                            onTap: () async{
                                              if (_check == false) {
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
                                                      title: Column(
                                                        children: [
                                                          Text(
                                                            "Are you sure to delete $selectedValue from doctors?",
                                                            style: TextStyle(
                                                              fontSize: mqh*0.023,
                                                              color:Colors.black,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                          Text(
                                                            "This can't be undone",
                                                            style: TextStyle(
                                                              fontSize: mqh*0.02,
                                                              fontWeight: FontWeight.bold,
                                                              color:Colors.black,
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ],
                                                      ),
                                                      contentPadding: EdgeInsets.zero,
                                                      actions: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            TextButton(
                                                              onPressed: ()async{
                                                                await FirebaseFirestore.instance.collection('doctor').doc(selectedValue.split('@')[0].toLowerCase()).
                                                                delete().then((value){
                                                                  Navigator.of(context).pop();
                                                                  Navigator.of(context).pop();
                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                    SnackBar(
                                                                      duration: const Duration(milliseconds:3500),
                                                                      content: Text(
                                                                        'Doctor Deleted Successfully !', 
                                                                        textAlign: TextAlign.center, 
                                                                        style: TextStyle(
                                                                          fontSize: mqh*0.03,
                                                                          fontFamily: 'Avenir',
                                                                          color: Colors.black
                                                                        ),
                                                                      ),
                                                                      backgroundColor: Colors.red[200],
                                                                      elevation: 5,
                                                                      behavior: SnackBarBehavior.floating,
                                                                      padding: EdgeInsets.all(mqw*0.04),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.all(Radius.circular(mqw*0.04))
                                                                      ),
                                                                    )
                                                                  );
                                                                });
                                                                setState(() {
                                                                  
                                                                });
                                                              },
                                                              child: Text(
                                                                "Yes",
                                                                style: TextStyle(
                                                                  fontSize:mqh*0.022
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
                                                                  fontSize:mqh*0.022
                                                                ),
                                                              )
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                            child: AnimatedContainer(
                                              duration: const Duration(seconds: 1),
                                              width: _check?mqw*0.125: mqw*0.4,
                                              height: mqw*0.125,
                                              alignment: Alignment.center,
                                              child: _check?
                                              const Icon(
                                                Icons.done, color: Colors.white,
                                              ) :
                                              Text(
                                                "Delete Doctor",
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
                                    ],
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