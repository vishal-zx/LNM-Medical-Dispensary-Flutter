import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({ Key? key }) : super(key: key);

  @override
  _AddDoctorState createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {
  final formKey = GlobalKey<FormState>();
  final _check1 = false; 
  final _check = false;
  bool _checkEmail = false;
  String email = "";
  String username = "";
  bool registered = false;
  List<String> docEmails = [];
   

  Future<void> getDocs() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('doctor').get();
    for(var doc in qs.docs){
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      docEmails.add(data['Email']);
    }
  }

  @override
  void initState(){
    getDocs().whenComplete(() => setState((){}));
    super.initState();
  }

  check(BuildContext context) async{
    if(formKey.currentState!.validate()){
      setState(() {
        _checkEmail = true;
      });
    }
    else{
      setState(() {
        _checkEmail = false;
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
        backgroundColor: Colors.red[300],
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
                      "Add Doctor",
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
                            color: Colors.red[100],
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
                                    Text(
                                      "(only a-z, 0-9, '.', '-' allowed)",
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
                                        hintText: "Enter new doctor's email",
                                        suffixText: "@lnmiit.ac.in",
                                      ),
                                      validator: (value){
                                        if(value!.isEmpty){
                                          return "Email can't be Empty!";
                                        }
                                        return null;
                                      },
                                      onChanged: (value){
                                        setState(() {
                                          value = value.replaceAll(' ', '');
                                          username = value;
                                          email = value + "@lnmiit.ac.in";
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height:mqh*0.06
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Material(
                                        color: (_check1 == true)?Colors.red[300]:Colors.red,
                                        borderRadius: BorderRadius.circular(_check?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: () async{
                                            if(_check == false){
                                              check(context);
                                              if(_checkEmail){
                                                var fl=0;
                                                for(var docEm in docEmails){
                                                  if(email.toLowerCase() == docEm)
                                                  {
                                                    fl=1;
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        duration: const Duration(milliseconds:3500),
                                                        content: Text(
                                                          'Doctor already exists !!', 
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
                                                      )
                                                    );
                                                  }
                                                }
                                                if(fl==0){
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
                                                              "Are you sure to add $email as doctor to database?",
                                                              style: TextStyle(
                                                                fontSize: mqh*0.023,
                                                                color:Colors.black,
                                                              ),
                                                              textAlign: TextAlign.center,
                                                            ),
                                                            Text(
                                                              "(On registering $email can choose between the doctor and patient role)",
                                                              style: TextStyle(
                                                                fontSize: mqh*0.018,
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
                                                                  await FirebaseFirestore.instance.collection('doctor').doc(username.toLowerCase()).
                                                                  set({'Email' : email.toLowerCase()}).then((value){
                                                                    Navigator.of(context).pop();
                                                                    Navigator.of(context).pop();
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                      SnackBar(
                                                                        duration: const Duration(milliseconds:3500),
                                                                        content: Text(
                                                                          'Doctor Added Successfully !', 
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
                                              }
                                            }
                                          },
                                          child: AnimatedContainer(
                                            duration: const Duration(seconds: 1),
                                            width: _check?mqw*0.125: mqw*0.35,
                                            height: mqw*0.125,
                                            alignment: Alignment.center,
                                            child: _check?
                                            const Icon(
                                              Icons.done, color: Colors.white,
                                            ) :
                                            Text(
                                              "Add Doctor",
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
                                      height:mqh*0.04
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Doctors Added:",
                                          style:TextStyle(
                                            fontSize: mqh*0.03,
                                            color: Colors.black,
                                          )
                                        ),
                                        Text(
                                          "(this may contain those doctors, added by the admin but not registered by themselves)",
                                          style:TextStyle(
                                            fontSize: mqh*0.017,
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height:mqh*0.008
                                        ),
                                        if(docEmails.isEmpty)
                                        Center(
                                          child: SizedBox(
                                            height:mqw*0.05,
                                            width:mqw*0.05,
                                            child: const CircularProgressIndicator(
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        for(var doc in docEmails)
                                        Text(
                                          doc,
                                          style:TextStyle(
                                            fontSize: mqh*0.02,
                                            color: Colors.black,
                                          )
                                        ),
                                      ],
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