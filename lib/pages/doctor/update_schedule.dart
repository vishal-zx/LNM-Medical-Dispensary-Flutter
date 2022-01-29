import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateSchedule extends StatefulWidget {
  const UpdateSchedule({ Key? key }) : super(key: key);

  @override
  _UpdateScheduleState createState() => _UpdateScheduleState();
}

class _UpdateScheduleState extends State<UpdateSchedule> {
  final formKey = GlobalKey<FormState>();
  bool _check1 = false; 
  bool loaded = false; 
  var username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');
  List<String> days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
  Map<String, Map<String, List<String>>> schedule = {};

  bool check(){
    for(int i = 0; i < days.length; i++) {
      if(schedule[days[i]]!['S1']![0]=='' && schedule[days[i]]!['S1']![1]!=''){
        return false;
      }
      if(schedule[days[i]]!['S1']![1]=='' && schedule[days[i]]!['S1']![0]!=''){
        return false;
      }
      if(schedule[days[i]]!['S2']![0]=='' && schedule[days[i]]!['S2']![1]!=''){
        return false;
      }
      if(schedule[days[i]]!['S2']![1]=='' && schedule[days[i]]!['S2']![0]!=''){
        return false;
      }
      if(schedule[days[i]]!['S1']![0].compareTo(schedule[days[i]]!['S1']![1])>0){
        String t = schedule[days[i]]!['S1']![0];
        schedule[days[i]]!['S1']![0] = schedule[days[i]]!['S1']![1];
        schedule[days[i]]!['S1']![1] = t;
      }
      if(schedule[days[i]]!['S2']![0].compareTo(schedule[days[i]]!['S2']![1])>0){
        String t = schedule[days[i]]!['S2']![0];
        schedule[days[i]]!['S2']![0] = schedule[days[i]]!['S2']![1];
        schedule[days[i]]!['S2']![1] = t;
      }
    }
    return true;
  }

  Future<void> loadSchedules()async{
    schedule.clear();
    for (var i=0; i<days.length; i++) {
      schedule[days[i]] = {
        'S1': List<String>.generate(2, (_) => ''),
        'S2': List<String>.generate(2, (_) => ''),
      };
    }
    DocumentSnapshot qs = await FirebaseFirestore.instance.collection('doctor').doc(username).get();
    Map<String, dynamic> data = qs.data() as Map<String, dynamic>;
    var sschedule = data['Schedule'];
    sschedule.forEach((key, value) {
      value.forEach((k, v) {
        int i=0;
        for(var val in v){
          schedule[key.toString()]![k.toString()]![i++] = val.toString();
        }
      });
    });
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
          fontSize: mqh*0.018,
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
  
  @override
  void initState(){
    loadSchedules().then((value){
      setState(() {
        loaded = true;
      });
    });
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
                      "Update Working Hours",
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
                            padding: EdgeInsets.only(right:mqw*0.05),
                            width: mqw*0.84,
                            height: mqh*0.755,
                            child: Form(
                              key: formKey,
                              child: (!loaded)?Center(
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
                                    Center(
                                      child: Text(
                                        "Note: You can add upto 2 schedules per day only.",
                                        style:TextStyle(
                                          fontSize: mqh*0.015,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height:mqh*0.02
                                    ),
                                    for(int i = 0; i<days.length; i++)
                                    ...[
                                      Center(
                                        child: Text(
                                          days[i],
                                          style:TextStyle(
                                            fontSize: mqh*0.025,
                                            color: Colors.black,
                                          )
                                        ),
                                      ), 
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                "Schedule 1",
                                                style:TextStyle(
                                                  fontSize: mqh*0.015,
                                                  color: Colors.black,
                                                )
                                              ), 
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: mqw*0.16,
                                                    child: DateTimePicker(
                                                      type: DateTimePickerType.time,
                                                      initialTime: (schedule[days[i]]!['S1']![0]=="")?
                                                      const TimeOfDay(hour: 09, minute: 00): 
                                                      TimeOfDay(
                                                        hour: int.parse(schedule[days[i]]!['S1']![0].substring(0,2)), 
                                                        minute: int.parse(schedule[days[i]]!['S1']![0].substring(3,5)),
                                                      ),
                                                      timeHintText: (schedule[days[i]]!['S1']![0]=="")?
                                                      "From":schedule[days[i]]!['S1']![0],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: mqh*0.016,
                                                        color: Colors.black,
                                                      ),
                                                      onChanged: (val) {
                                                        schedule[days[i]]!['S1']![0] = val;
                                                      },
                                                      validator: (val) {
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        return;
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: mqw*0.02,
                                                  ),
                                                  SizedBox(
                                                    width: mqw*0.16,
                                                    child: DateTimePicker(
                                                      type: DateTimePickerType.time,
                                                      initialTime: (schedule[days[i]]!['S1']![1]=="")?
                                                      const TimeOfDay(hour: 09, minute: 30): 
                                                      TimeOfDay(
                                                        hour: int.parse(schedule[days[i]]!['S1']![1].substring(0,2)), 
                                                        minute: int.parse(schedule[days[i]]!['S1']![1].substring(3,5)),
                                                      ),
                                                      timeHintText: (schedule[days[i]]!['S1']![1]=="")?
                                                      "To":schedule[days[i]]!['S1']![1],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: mqh*0.016,
                                                        color: Colors.black,
                                                      ),
                                                      onChanged: (val) {
                                                        schedule[days[i]]!['S1']![1] = val;
                                                      },
                                                      validator: (val) {
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        return;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                "Schedule 2",
                                                style:TextStyle(
                                                  fontSize: mqh*0.015,
                                                  color: Colors.black,
                                                )
                                              ), 
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: mqw*0.16,
                                                    child: DateTimePicker(
                                                      type: DateTimePickerType.time,
                                                      initialTime: (schedule[days[i]]!['S2']![0]=="")?
                                                      const TimeOfDay(hour: 09, minute: 00): 
                                                      TimeOfDay(
                                                        hour: int.parse(schedule[days[i]]!['S2']![0].substring(0,2)), 
                                                        minute: int.parse(schedule[days[i]]!['S2']![0].substring(3,5)),
                                                      ),
                                                      timeHintText: (schedule[days[i]]!['S2']![0]=="")?
                                                      "From":schedule[days[i]]!['S2']![0],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: mqh*0.016,
                                                        color: Colors.black,
                                                      ),
                                                      onChanged: (val) {
                                                        schedule[days[i]]!['S2']![0] = val;
                                                      },
                                                      validator: (val) {
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        return;
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: mqw*0.02,
                                                  ),
                                                  SizedBox(
                                                    width: mqw*0.16,
                                                    child: DateTimePicker(
                                                      type: DateTimePickerType.time,
                                                      initialTime: (schedule[days[i]]!['S2']![1]=="")?
                                                      const TimeOfDay(hour: 09, minute: 30): 
                                                      TimeOfDay(
                                                        hour: int.parse(schedule[days[i]]!['S2']![1].substring(0,2)), 
                                                        minute: int.parse(schedule[days[i]]!['S2']![1].substring(3,5)),
                                                      ),
                                                      timeHintText: (schedule[days[i]]!['S2']![1]=="")?
                                                      "To":schedule[days[i]]!['S2']![1],
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: mqh*0.016,
                                                        color: Colors.black,
                                                      ),
                                                      onChanged: (val) {
                                                        schedule[days[i]]!['S2']![1] = val;
                                                      },
                                                      validator: (val) {
                                                        return null;
                                                      },
                                                      onSaved: (val) {
                                                        return;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height:mqh*0.03
                                      ), 
                                    ],
                                    Center(
                                      child: Text(
                                        "(If 'From' timings are after 'To' timings,\nthey will be swapped automatically.)",
                                        style:TextStyle(
                                          fontSize: mqh*0.012,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.red,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      height:mqh*0.02
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (_check1 == true)?Colors.blue[300]:Colors.blue,
                                        borderRadius: BorderRadius.circular(_check1?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: () async{
                                            bool isOkay = check();
                                            if(isOkay){
                                              if(!_check1){
                                                setState((){
                                                  _check1 = !_check1;
                                                });
                                                await FirebaseFirestore.instance.collection('doctor')
                                                .doc(username).update({'Schedule':schedule}).whenComplete((){
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar('Schedule Modified !!'));
                                                  setState((){
                                                    _check1 = !_check1;
                                                  });
                                                });
                                              }
                                            }else{
                                              ScaffoldMessenger.of(context).showSnackBar(snackBar('Please select both From & To time for a schedule !!'));
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
                                              "Update",
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
                                      height:mqh*0.02
                                    ),
                                    SizedBox(
                                      height:mqh*0.005
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