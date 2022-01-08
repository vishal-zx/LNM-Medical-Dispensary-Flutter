import 'dart:core';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class RequestMedCert extends StatefulWidget {
  const RequestMedCert({ Key? key }) : super(key: key);

  @override
  _RequestMedCertState createState() => _RequestMedCertState();
}

class _RequestMedCertState extends State<RequestMedCert> {
  final formKey = GlobalKey<FormState>();

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
  String reason = "";
  // DateTime selectedFromDate = DateTime.now().add(const Duration(days: 2));
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now().add(const Duration(days: 2));

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
                      "Request Medical Certificate",
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
                                    SizedBox(
                                      height:mqh*0.015
                                    ),
                                    DropdownButtonFormField(
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.amberAccent.shade100, width: 2),
                                          borderRadius: BorderRadius.circular(mqh*0.02),
                                        ),
                                        filled: true,
                                        fillColor: Colors.amberAccent[100],
                                      ),
                                      dropdownColor: Colors.amberAccent[100],
                                      value: selectedValue,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedValue = newValue!;
                                        });
                                      },
                                      items: dropdownItems
                                    ),
                                    SizedBox(
                                      height:mqh*0.04
                                    ),
                                    Text(
                                      "Date",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    Text(
                                      "(You can only select a period of maximum 14 days.)",
                                      style:TextStyle(
                                        fontSize: mqh*0.015,
                                        color: Colors.black87,
                                      )
                                    ),
                                    SizedBox(
                                      height:mqh*0.01
                                    ),
                                    Text(
                                      "From",
                                      style:TextStyle(
                                        fontSize: mqh*0.025,
                                        color: Colors.black87,
                                      )
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: DateFormat("dd MMMM yyyy").format(DateTime.now()),
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
                                              helpText: 'Select From Date for Certificate',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now().subtract(const Duration(days: 30)),
                                              lastDate: DateTime.now(),
                                            ).then((pickedDate) {
                                              if (pickedDate == null) {
                                                return;
                                              }
                                              setState(() {
                                                selectedFromDate = pickedDate;
                                                if((selectedToDate.difference(selectedFromDate)).inDays > 14){
                                                  selectedToDate = selectedFromDate.add(const Duration(days:14));
                                                }
                                                if((selectedFromDate.difference(selectedToDate)).inDays>0){
                                                  selectedToDate = selectedFromDate.add(const Duration(days:2));
                                                }
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
                                      controller: TextEditingController()..text = DateFormat("dd MMMM yyyy").format(selectedFromDate),
                                    ),
                                    SizedBox(
                                      height:mqh*0.025
                                    ),
                                    Text(
                                      "To",
                                      style:TextStyle(
                                        fontSize: mqh*0.025,
                                        color: Colors.black87,
                                      )
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: DateFormat("dd MMMM yyyy").format(selectedFromDate),
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
                                              helpText: 'Select To Date for Certificate',
                                              initialDate: selectedToDate,
                                              firstDate: selectedFromDate,
                                              lastDate: selectedFromDate.add(const Duration(days: 14)),
                                            ).then((pickedDate) {
                                              if (pickedDate == null) {
                                                return;
                                              }
                                              setState(() {
                                                selectedToDate = pickedDate;
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
                                      controller: TextEditingController()..text = DateFormat("dd MMMM yyyy").format(selectedToDate),
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
                                        hintText: "Enter reason for medical certificate",
                                      ),
                                      maxLength: 100,
                                      onChanged:(value){
                                        reason = value;
                                      },
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
                                              "Request",
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