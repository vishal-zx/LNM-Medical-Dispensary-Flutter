import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:search_choices/search_choices.dart';

class PMedRec extends StatelessWidget {
  const PMedRec({ Key? key, required this.patHis }) : super(key: key);

  final PatHistory patHis;

  void _requestDownload(String link) async {
    await FlutterDownloader.enqueue(
      url: link,
      savedDir: '/storage/emulated/0/Download',
      showNotification: true,
      openFileFromNotification: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[300],
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title:Container(
            alignment:Alignment.centerRight,
            child: Text(
              "Medical Record",
              style:TextStyle(
                fontSize: mqh*0.044,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              )
            ),
          ),
          // automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.cyan[300],
        body: SafeArea(
          child: SingleChildScrollView( // REMEMBER TO REMOVE THIS WIDGET
            child: Container(
              alignment: Alignment.bottomRight,
              height: mqh-MediaQuery.of(context).padding.top - AppBar().preferredSize.height,
              width: mqw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                            child: Column(
                              children:[
                                Container(
                                  padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                                  width: mqw*0.84,
                                  height: mqh*0.755,
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(), 
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Patient",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.patient,
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Text(
                                          "Doctor",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          "Dr. "+patHis.doctor,
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Text(
                                          "Timings",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.dateTime.substring(0,8)+", "+patHis.dateTime.substring(9),
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Text(
                                          "Reason",
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.reason,
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Text(
                                          "Prescription",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.prescription,
                                          softWrap: true,
                                          maxLines: 10,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Text(
                                          "Other Instructions",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.instruction,
                                          softWrap: true,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Text(
                                          "Refer to (if any)",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqw*0.06,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          patHis.refer,
                                          softWrap: true,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style:TextStyle(
                                            fontSize: mqw*0.05,
                                            color: Colors.black87,
                                          )
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Material(
                                            color: Colors.blue[300],
                                            borderRadius: BorderRadius.circular(mqw*0.03),
                                            child: InkWell(
                                              onTap: () {
                                                _requestDownload('https://firebasestorage.googleapis.com/v0/b/lnmmeddis.appspot.com/o/Vishal%20Gupta.pdf?alt=media&token=8ad40c4d-567b-4f5b-be2c-12d73f0a31c1');
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(seconds: 1),
                                                width: mqw*0.7,
                                                height: mqw*0.125,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Download Medical Record",
                                                  style: TextStyle(
                                                    color: Colors.black87, 
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: mqh*0.025,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: mqh*0.035,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
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

class PatHistory{
  String doctor = "";
  String patient = "";
  String dateTime = "";
  String reason = "";
  String prescription = "";
  String instruction = "";
  String refer = "";

  PatHistory(this.doctor, this.patient, this.dateTime, this.reason, this.prescription , this.instruction, this.refer);
}

class ViewPatHis extends StatefulWidget {
  const ViewPatHis({ Key? key }) : super(key: key);

  @override
  _ViewPatHisState createState() => _ViewPatHisState();
}

class _ViewPatHisState extends State<ViewPatHis> {
  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("USA"), value: "USA"),
      const DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      const DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      const DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }
  
  String selectedValue = "";
  bool isPatientSelected = false;

  List<PatHistory> patHis = [
      PatHistory('Ajay Nair', 'Gunit Varshney', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever fever fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Chand Singh', 'Saumitra Vyas', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ Take Paracetamol XYZ 600mg','',''),
      PatHistory('Amit Malhotra', 'Ketan Jakhar', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Aabha Gupta', 'Mayank Vyas', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Ajay Nair', 'Gunit Varshney', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Chand Singh', 'Saumitra Vyas', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Amit Malhotra', 'Ketan Jakhar', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Aabha Gupta', 'Mayank Vyas', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Ajay Nair', 'Gunit Varshney', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Chand Singh', 'Saumitra Vyas', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Amit Malhotra', 'Ketan Jakhar', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
      PatHistory('Aabha Gupta', 'Mayank Vyas', DateFormat("dd-MM-yy, hh:mm a").format(DateTime.now()), 'fever', 'Take Paracetamol XYZ 600mg','',''),
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
                      "View Patient \nMedical History",
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
                                    padding: EdgeInsets.only(right:mqw*0.04, left:mqw*0.09),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Select Patient",
                                          style:TextStyle(
                                            fontSize: mqh*0.035,
                                            color: Colors.black87,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SearchChoices.single(
                                          items: dropdownItems,
                                          value: selectedValue,
                                          hint: "Select one",
                                          searchHint: null,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValue = value;
                                              isPatientSelected = true;
                                            });
                                          },
                                          style:TextStyle(
                                            fontSize: mqh*0.025,
                                            color: Colors.black,
                                            fontFamily: 'Avenir'
                                          ),
                                          menuBackgroundColor: Colors.cyanAccent[100],
                                          dialogBox: true,
                                          isExpanded: true,
                                          onClear: (){
                                            setState(() { 
                                              isPatientSelected = false;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(isPatientSelected)
                                  Container(
                                    padding: EdgeInsets.only(left:mqw*0.07, right:mqw*0.02),
                                    width: mqw*0.84,
                                    height: mqh*0.615,
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(), 
                                      itemCount: patHis.length,
                                      itemBuilder: (context, index){
                                        return GestureDetector(
                                          onTap:(){
                                            Navigator.push(
                                              context, 
                                              PageTransition(
                                                type: PageTransitionType.bottomToTop, 
                                                duration: const Duration(milliseconds: 400),
                                                child: PMedRec(patHis: patHis[index]),
                                                childCurrent: const ViewPatHis()
                                              )
                                            );
                                          },
                                          child: SizedBox(
                                            child: Card(  
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(mqh*0.01)
                                              ),
                                              color: Colors.cyan[300],
                                              child: Container(
                                                padding: EdgeInsets.all(mqw*0.02),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                            " "+ patHis[index].patient,
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
                                                            " "+ patHis[index].doctor,
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
                                                            " "+ patHis[index].dateTime,
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
                                                            patHis[index].reason,
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
                                                    SizedBox(
                                                      height:mqh*0.01
                                                    ),
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Prescription:",
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
                                                            patHis[index].prescription,
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
                                            )
                                          ),
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