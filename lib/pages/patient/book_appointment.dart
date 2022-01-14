import 'dart:core';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
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

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("USA"), value: "USA"),
      const DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      const DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      const DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }
  
  String selectedValue = "USA";
  num selectedTimeSlot = 0;
  String reason = "";
  bool isAppointUrgent = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds:2), () {
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
                              child: SingleChildScrollView(
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
                                      items: dropdownItems,
                                      value: selectedValue,
                                      hint: "Select one",
                                      searchHint: null,
                                      onChanged: (value) {
                                        setState(() {
                                          selectedValue = value;
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
                                      controller: TextEditingController()..text = DateFormat("dd MMMM yyyy").format(selectedDate) + " " + ((times==null)?'':times[selectedTimeSlot]),
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
                                              Icon(
                                                Icons.refresh,
                                                size:mqh*0.025
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
                                            setState((){
                                              _check1 = !_check1;
                                            });
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