import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:search_choices/search_choices.dart';

class SubmitFeedback extends StatefulWidget {
  const SubmitFeedback({ Key? key }) : super(key: key);

  @override
  _SubmitFeedbackState createState() => _SubmitFeedbackState();
}

class _SubmitFeedbackState extends State<SubmitFeedback> {
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
  String feedback = "";
  List<bool> stars = [true, false, false, false, false];
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
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (_check1 == true)?Colors.orange[300]:Colors.orange,
                                        borderRadius: BorderRadius.circular(_check1?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: () {
                                            setState((){
                                              _check1 = !_check1;
                                              int i=0;
                                              for(i=0;i<5;i++){
                                                if(stars[i] == false){
                                                  break;
                                                }
                                              }
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