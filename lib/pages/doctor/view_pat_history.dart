import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:search_choices/search_choices.dart';
import '../../apis/medrecord_pdf_api.dart';
import '../../apis/pdf_api.dart';
import '../../models/med_record.dart';

class PMedRec extends StatelessWidget {
  const PMedRec({ Key? key, required this.patHis, required this.patDetails}) : super(key: key);

  final PatHistory patHis;
  final PatDetails patDetails;

  void buildMedRecord() async {
    var medRec = MedRec(
      patHis: patHis,
      patDetails: patDetails,
    );

    final pdfFile = await PdfMedRecordApi.generate(medRec);
    PdfApi.openFile(pdfFile);
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
                    alignment:Alignment.centerLeft,
                    padding: EdgeInsets.only(left:mqw*0.09),
                    child: Text(
                      "Medical Record",
                      style:TextStyle(
                        fontSize: mqh*0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      )
                    ),
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
                                          patHis.dateTime.substring(0,10)+", "+patHis.dateTime.substring(11),
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
                                                buildMedRecord();
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(seconds: 1),
                                                width: mqw*0.7,
                                                height: mqw*0.125,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "View Medical Record",
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

class PatDetails{
  String name = "";
  String email = "";
  String age = "";
  String mob = "";
  String gender = "";

  PatDetails(this.name, this.email, this.age, this.mob, this.gender);
}

class ViewPatHis extends StatefulWidget {
  const ViewPatHis({ Key? key }) : super(key: key);

  @override
  _ViewPatHisState createState() => _ViewPatHisState();
}

class _ViewPatHisState extends State<ViewPatHis> {
  final formKey = GlobalKey<FormState>();
  
  String selectedPatValue = "";
  bool isPatientSelected = false;
  bool dataLoadedPat = false;
  bool hisLoaded = false;
  List<DropdownMenuItem<String>> dropDownPats = [];
  List<PatHistory> patHis = [];
  late PatDetails pd;

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
  
  Future<void> getPatHis(String pat) async{
    patHis.clear();
    DocumentSnapshot qs = await FirebaseFirestore.instance.collection('patientHistory').doc(pat).get();
    var history = qs.data() as Map<String, dynamic>;
    history.forEach((key, value) async{
      QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo: pat).get();
      String pName = qsP.docs[0]['FirstName']!+" "+qsP.docs[0]['LastName']!;
      pd = PatDetails(pName, qsP.docs[0]['Email'], qsP.docs[0]['Age'], qsP.docs[0]['Mob'], (qsP.docs[0]['isMale'])?"Male":"Female");
      QuerySnapshot qsD = await FirebaseFirestore.instance.collection('doctor').where('Username', isEqualTo:key).get();
      String dName = qsD.docs[0]['FirstName']!+" "+qsD.docs[0]['LastName']!;
      for(var i in value){
        var his = i as Map<String, dynamic>;
        patHis.add(
          PatHistory(dName, pName, his['Timing']!, his['Reason']!, his['Prescription']!, his['OtherIns']!, his['Refer']!)
        );
        setState(() {});
      }
    });
  }


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
                              child: Column(
                                children:[
                                  Container(
                                    padding: EdgeInsets.only(right:mqw*0.04, left:mqw*0.09),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
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
                                              hisLoaded = false;
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
                                              isPatientSelected = true;
                                              getPatHis(selectedPatValue).whenComplete(() => {
                                                setState(() {
                                                  Future.delayed(const Duration(milliseconds: 500),(){
                                                    hisLoaded = true;
                                                  });
                                                })
                                              });
                                            });
                                          },
                                          menuBackgroundColor: Colors.cyan[100],
                                          dialogBox: true,
                                          isExpanded: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if(isPatientSelected)
                                  (!hisLoaded)?Center(
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
                                          "Loading Patient History ...",
                                          textAlign: TextAlign.center,
                                          style:TextStyle(
                                            fontSize: mqh*0.02,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ):
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
                                                child: PMedRec(patHis: patHis[index], patDetails: pd),
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
                                                            " Dr. "+ patHis[index].doctor,
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