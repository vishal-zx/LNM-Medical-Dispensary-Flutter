import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({ Key? key }) : super(key: key);

  @override
  _PatientHomeState createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  String username = "";
  String email = "";
  String fName = "";
  String lName = "";
  bool isMale = true;
  String emailReset = "";
  String password = "";
  String mob = "";
  String age = "";

  bool _check = false;
  bool _check1 = false;
  final formKey = GlobalKey<FormState>(); 
  final formKeyReset = GlobalKey<FormState>(); 
  bool _showPass = true;

  SnackBar makeBar(String text){
    final snackBar = SnackBar(
      duration: Duration(milliseconds: (text=="Loading...")?700:3000),
      content: Text(text, textAlign: TextAlign.center, 
        style: const TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.black87.withOpacity(0.89),
      elevation: 3,
      padding: const EdgeInsets.all(5),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
    );
    return snackBar;
  }

  void _togglePass(){
    setState(() {
      _showPass = !_showPass;
    });
  }

  check(BuildContext context) async{
    if(formKey.currentState!.validate()){
      setState(() {
        _check1 = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Colors.brown[400],
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
                      "Sign Up",
                      style:TextStyle(
                        fontSize: mqh*0.06,
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
                            color: Colors.brown[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(mqh*0.05),
                            )
                          ),
                          alignment: Alignment.bottomRight,
                          width: mqw*0.92,
                          height: mqh*0.8,
                          child: Stack(
                            clipBehavior: Clip.none, 
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.brown[50],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(mqh*0.05),
                                  )
                                ),
                                alignment: Alignment.bottomRight,
                                width: mqw*0.85,
                                height: mqh*0.75,
                                child: Container(
                                  padding: EdgeInsets.only(left:mqw*0.05, right:mqw*0.08),
                                  width: mqw*0.8,
                                  height: mqh*0.7,
                                  child:Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Email",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          Text(
                                            "(can include only lowercase letters, '.' and '-')",
                                            style:TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontSize: mqh*0.015,
                                              color: Colors.black45,
                                            )
                                          ),
                                          SizedBox(
                                            height:mqh*0.004
                                          ),
                                          TextFormField(
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp("[a-z0-9.-]")),
                                            ],
                                            decoration: const InputDecoration(
                                              hintText: "Enter your email",
                                              suffixText: "@lnmiit.ac.in",
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Email can't be Empty!";
                                              }
                                              return null;
                                            },
                                            onChanged: (value){
                                              value = value.replaceAll(' ', '');
                                              username = value;
                                              email = value + "@lnmiit.ac.in";
                                              setState(() {
                                                
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "Username",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          TextFormField(
                                            readOnly: true,
                                            controller: TextEditingController()..text = (email == "")?"":username,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp("[a-z0-9.-]")),
                                            ],
                                            decoration: const InputDecoration(
                                              hintText: "Your username",
                                            ),
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "First Name",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              hintText: "Enter your first name",
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "First name can't be Empty!";
                                              }
                                              return null;
                                            },
                                            onChanged: (value){
                                              fName = value;
                                              setState(() {
                                                
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "Last Name",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          TextFormField(
                                            decoration: const InputDecoration(
                                              hintText: "Enter your last name",
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){
                                                return "Last name can't be Empty!";
                                              }
                                              return null;
                                            },
                                            onChanged: (value){
                                              lName = value;
                                              setState(() {
                                                
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "Password",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          TextFormField(
                                            obscureText: _showPass,
                                            decoration: InputDecoration(
                                              hintText: "Enter new password",
                                              suffix: InkWell(
                                                onTap: _togglePass,
                                                child: Icon(
                                                  _showPass?Icons.visibility:Icons.visibility_off,
                                                  size: mqh*0.025
                                                ),
                                              )
                                            ),
                                            validator: (value){
                                              if(value!.isEmpty){return "Password can't be Empty!";}
                                              else {return null;}
                                            },
                                            onChanged: (value){
                                              password = value;
                                              setState(() {
                                                
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "Mobile Number",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          TextFormField(
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                            ],
                                            decoration: const InputDecoration(
                                              hintText: "Enter your mobile number",
                                            ),
                                            keyboardType: TextInputType.phone,
                                            onChanged:(value){
                                              mob = value;
                                            }
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "Age",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          TextFormField(
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                                            ],
                                            decoration: const InputDecoration(
                                              hintText: "Enter your age",
                                            ),
                                            keyboardType: TextInputType.number,
                                            onChanged:(value){
                                              age = value;
                                            }
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Text(
                                            "Gender",
                                            style:TextStyle(
                                              fontSize: mqh*0.035,
                                              color: Colors.black87,
                                            )
                                          ),
                                          SizedBox(
                                            height:mqh*0.005
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.male,
                                                  size:mqh*0.05,
                                                ),
                                                onPressed: () {
                                                  setState((){
                                                    isMale = true;
                                                  });
                                                },
                                                color: isMale?Colors.brown[500]:Colors.brown[200],
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.female,
                                                  size:mqh*0.05,
                                                ),
                                                onPressed: () {
                                                  setState((){
                                                    isMale = false;
                                                  });
                                                },
                                                color: isMale?Colors.brown[200]:Colors.brown[500],
                                              ),
                                            ]
                                          ),
                                          SizedBox(
                                            height:mqh*0.06
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Material(
                                              color: (_check1 == true)?Colors.brown[300]:Colors.brown,
                                              borderRadius: BorderRadius.circular(_check?mqw*0.1:mqw*0.03),
                                              child: InkWell(
                                                onTap: () {
                                                  setState((){
                                                    _check1 = !_check1;
                                                    _check = !_check;
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(seconds: 1),
                                                  width: _check?mqw*0.125: mqw*0.3,
                                                  height: mqw*0.125,
                                                  alignment: Alignment.center,
                                                  child: _check?
                                                  const Icon(
                                                    Icons.done, color: Colors.white,
                                                  ) :
                                                  Text(
                                                    "Sign Up",
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
                                        ],
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ],
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