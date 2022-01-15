import 'dart:core';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({ Key? key }) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final formKey = GlobalKey<FormState>();
  bool _check1 = false; 
  String username = "19ucs053";
  bool _check = false;
  String email = "19ucs053@lnmiit.ac.in";
  String fName = "";
  String lName = "";
  bool isMale = true;
  String mob = "";
  String age = "";

  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("USA"), value: "USA"),
      const DropdownMenuItem(child: Text("Canada"), value: "Canada"),
      const DropdownMenuItem(child: Text("Brazil"), value: "Brazil"),
      const DropdownMenuItem(child: Text("England"), value: "England"),
    ];
    return menuItems;
  }

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
                    padding: EdgeInsets.only(left:mqw*0.09),
                    child: Text(
                      "Update Profile",
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
                                physics: const BouncingScrollPhysics(), 
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:[
                                    Text(
                                      "Email",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      controller: TextEditingController()..text = email,
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
                                      controller: TextEditingController()..text = username,
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
                                          color: isMale?Colors.orange[800]:Colors.orange[300],
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
                                          color: isMale?Colors.orange[300]:Colors.orange[800],
                                        ),
                                      ]
                                    ),
                                    SizedBox(
                                      height:mqh*0.06
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (_check1 == true)?Colors.orange[300]:Colors.orange,
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