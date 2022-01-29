import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';

class BookAppointment extends StatefulWidget {
  const BookAppointment({ Key? key }) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final formKey = GlobalKey<FormState>();

  Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
            (hour == endTime.hour && minute <= endTime.minute));
  }

  final startTime = const TimeOfDay(hour: 9, minute: 0);
  final endTime = const TimeOfDay(hour: 17, minute: 0);
  final step = const Duration(minutes: 30);

  // ignore: prefer_typing_uninitialized_variables
  var times;
  bool _check1 = false; 

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

  List<DropdownMenuItem<String>> dropDownDocs = [];

  Future<void> getDoctors() async{
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
  }
  
  String selectedValue = "";
  num selectedTimeSlot = -1;
  String reason = "";
  bool isAppointUrgent = false;
  bool dataLoaded = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState(){
    if(dropDownDocs.isEmpty){
      getDoctors().then((value){
        setState(() {
          dataLoaded = true;
        });
      });
    }
    super.initState();
    Future.delayed(const Duration(seconds:0), () {
        times = getTimes(startTime, endTime, step).map((tod) => tod.format(context)).toList();
    });
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
                    padding: EdgeInsets.only(left:mqw*0.09),
                    child: Text(
                      "Book Appointment",
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
                                physics: const BouncingScrollPhysics(),
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
                                      value: selectedValue,
                                      hint: "Select one",
                                      searchHint: null,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = (value==null)?"":value;
                                          Future.delayed(const Duration(seconds:0), () {
                                              times = getTimes(startTime, endTime, step).map((tod) => tod.format(context)).toList();
                                          }).whenComplete(() => setState((){}));
                                          selectedTimeSlot = -1;
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
                                    Text(
                                      "Preferred Date & Time",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: DateFormat("dd MMMM yyyy").format(selectedDate),
                                        suffix: InkWell(
                                          onTap: () {
                                            showDatePicker(
                                              context: context,
                                              builder: (context, child) {
                                                return Theme(
                                                  data: Theme.of(context).copyWith(
                                                    colorScheme: ColorScheme.light(
                                                      primary: Colors.amber.shade300,
                                                      onPrimary: Colors.black,
                                                      onSurface: Colors.black,
                                                    ),
                                                  ),
                                                  child: child!,
                                                );
                                              },
                                              helpText: 'Select Date for Appointment',
                                              initialDate: selectedDate,
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime.now().add(const Duration(days: 14)),
                                            ).then((pickedDate) {
                                              if (pickedDate == null) {
                                                return;
                                              }
                                              setState(() {
                                                selectedDate = pickedDate;
                                                Future.delayed(const Duration(seconds:0), () {
                                                    times = getTimes(startTime, endTime, step).map((tod) => tod.format(context)).toList();
                                                }).whenComplete(() => setState((){}));
                                                selectedTimeSlot = -1;
                                              });
                                            });
                                          },
                                          child: Icon(
                                            Icons.date_range,
                                            size: mqh*0.033,
                                          ),
                                        ),
                                      ),
                                      readOnly: true,
                                      style:TextStyle(
                                        fontSize: mqh*0.023,
                                        color: Colors.black,
                                      ),
                                      controller: TextEditingController()..text = DateFormat("dd MMMM yyyy").format(selectedDate) + " " + ((times==null || selectedTimeSlot==-1)?'':times[selectedTimeSlot]),
                                    ),
                                    SizedBox(
                                      height:mqh*0.01
                                    ),
                                    Container(
                                      height: mqh*0.15,
                                      alignment: Alignment.center,
                                      child: GridView.builder(
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 1.5,
                                        ),
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: (times==null)?1:times.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState((){
                                                selectedTimeSlot = index;
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(mqh*0.007),
                                              decoration: BoxDecoration(
                                                color: (selectedTimeSlot==index)?Colors.blueGrey[600]:Colors.blueGrey[100],
                                                borderRadius: BorderRadius.all(Radius.circular(mqh*0.01))
                                              ),
                                              child: Center(child: (times==null)?
                                              Center(
                                                child: SizedBox(
                                                  height:mqw*0.05,
                                                  width:mqw*0.05,
                                                  child: const CircularProgressIndicator(
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ):
                                              Text(
                                                times[index],
                                                style:TextStyle(
                                                  fontSize: mqh*0.015,
                                                  color: (selectedTimeSlot==index)?Colors.white:Colors.black,
                                                )
                                              )),
                                            ),
                                          );
                                        },
                                      )
                                    ),
                                    SizedBox(
                                      height:mqh*0.04
                                    ),
                                    Text(
                                      "Reason",
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
                                        hintText: "Enter reason for appointment",
                                      ),
                                      maxLength: 35,
                                      onChanged:(value){
                                        reason = value;
                                      },
                                    ),
                                    SizedBox(
                                      height:mqh*0.04
                                    ),
                                    Text(
                                      "Type of Appointment",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    SizedBox(
                                      height:mqh*0.01
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Normal",
                                          style:TextStyle(
                                            fontSize: mqh*0.023,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Switch(
                                          value: isAppointUrgent, 
                                          onChanged: (bool value){
                                            setState((){
                                              isAppointUrgent = value;
                                            });
                                          }
                                        ),
                                        Text(
                                          "Emergency",
                                          style:TextStyle(
                                            fontSize: mqh*0.023,
                                            color: Colors.black87,
                                          )
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:mqh*0.05
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (_check1 == true)?Colors.orange[300]:Colors.orange,
                                        borderRadius: BorderRadius.circular(_check1?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: () {
                                            if(!_check1){
                                              if(selectedValue!=""){
                                                if(reason!=""){
                                                  if(selectedTimeSlot!=-1){
                                                    setState((){
                                                      _check1 = !_check1;
                                                      
                                                    });
                                                  }else{
                                                    ScaffoldMessenger.of(context).showSnackBar(snackBar('Please select a date-time slot!'));
                                                  }
                                                }else{
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar('Please enter a reason!'));
                                                }
                                              }else{
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar('Please select a doctor!'));
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
                                              "Book",
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