import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lnm_medical_dispensary/pages/admin/home.dart';
import 'package:lnm_medical_dispensary/pages/doctor/home.dart';
import 'package:lnm_medical_dispensary/pages/register.dart';
import 'package:page_transition/page_transition.dart';

import 'patient/home.dart';

class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String username = "";
  String emailReset = "";
  String password = "";
  int role = -1;
  bool _check = false;
  bool _check1 = false;
  final formKey = GlobalKey<FormState>(); 
  final formKeyReset = GlobalKey<FormState>(); 
  bool _showPass = true;

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

  alertBox(Widget child){
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.green.shade100,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mqw*0.03)),
            insetPadding: EdgeInsets.only(left:mqw*0.15),
            content: Container(
              alignment: Alignment.center,
              width:mqw*0.5,
              height:mqh*0.25,
              child: child,
            ),
          ),
        );
      }
    );
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
    }else{
      setState(() {
        _check1 = false;
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
        backgroundColor: Colors.green[400],
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
                      "Sign In",
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
                            color: Colors.green[200],
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
                                  color: Colors.lightGreen[100],
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Username",
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
                                          height:mqh*0.005
                                        ),
                                        TextFormField(
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(RegExp("[a-z0-9.-]")),
                                          ],
                                          decoration: const InputDecoration(
                                            hintText: "Enter your username",
                                          ),
                                          validator: (value){
                                            if(value!.isEmpty){
                                              return "Username can't be Empty!";
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
                                          "Password",
                                          style:TextStyle(
                                            fontSize: mqh*0.035,
                                            color: Colors.black87,
                                          )
                                        ),
                                        Text(
                                          "(case sensitive)",
                                          style:TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: mqh*0.015,
                                            color: Colors.black45,
                                          )
                                        ),
                                        SizedBox(
                                          height:mqh*0.002
                                        ),
                                        TextFormField(
                                          obscureText: _showPass,
                                          decoration: InputDecoration(
                                            hintText: "Enter your password",
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
                                        Container(
                                          alignment: Alignment.center,
                                          child: Material(
                                            color: (_check == true)?Colors.green[300]:Colors.green,
                                            borderRadius: BorderRadius.circular(_check?mqw*0.1:mqw*0.03),
                                            child: InkWell(
                                              onTap: () async{
                                                if(!_check){
                                                  check(context);
                                                  if(_check1){
                                                    alertBox(
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          SizedBox(
                                                            height:mqw*0.1,
                                                            width:mqw*0.1,
                                                            child: const CircularProgressIndicator(
                                                              color: Colors.green,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:mqh*0.035,
                                                          ),
                                                          Text(
                                                            "Signing in..\nPlease wait..",
                                                            textAlign: TextAlign.center,
                                                            style:TextStyle(
                                                              fontSize: mqh*0.02,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                    QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo: username).get();
                                                    QuerySnapshot qsD = await FirebaseFirestore.instance.collection('doctor').where('Username', isEqualTo: username).get();
                                                    QuerySnapshot qsA = await FirebaseFirestore.instance.collection('admin').where('Username', isEqualTo: username).get();
                                                    var docsP = qsP.docs;
                                                    var docsD = qsD.docs;
                                                    var docsA = qsA.docs;
                                                    if(docsP.isNotEmpty){
                                                      setState((){
                                                        role = 0;
                                                      });
                                                    }
                                                    else if(docsD.isNotEmpty){
                                                      setState((){
                                                        role = 1;
                                                      });
                                                    }
                                                    else if(docsA.isNotEmpty){
                                                      setState((){
                                                        role = 2;
                                                      });
                                                    }
                                                    try{
                                                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                                                        email: email, 
                                                        password: password
                                                      ).then((result){
                                                        User? user = FirebaseAuth.instance.currentUser;
                                                        if(user != null) {
                                                          if(role == 0){
                                                            Navigator.of(context).pop();
                                                            alertBox(
                                                              Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Icon(
                                                                    Icons.done, 
                                                                    color: Colors.green.shade500,
                                                                    size: mqh*0.04
                                                                  ),
                                                                  SizedBox(
                                                                    height:mqh*0.035,
                                                                  ),
                                                                  Text(
                                                                    "Patient Login\n$email",
                                                                    textAlign: TextAlign.center,
                                                                    style:TextStyle(
                                                                      fontSize: mqh*0.02,
                                                                      color: Colors.black,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                            Future.delayed(const Duration(seconds: 2), () {
                                                              Navigator.push(
                                                                context, PageTransition(
                                                                  type: PageTransitionType.rightToLeft, 
                                                                  duration: const Duration(milliseconds: 400),
                                                                  child: const PatientHome(),
                                                                )
                                                              );
                                                            });
                                                          }
                                                          else if(role==1 || role==2){
                                                            if(!user.emailVerified){
                                                              Navigator.of(context).pop();
                                                              alertBox(
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.error, 
                                                                      color: Colors.green.shade500,
                                                                      size: mqh*0.04
                                                                    ),
                                                                    SizedBox(
                                                                      height:mqh*0.035,
                                                                    ),
                                                                    Text(
                                                                      "You're trying to login as ${(role==1)?"Doctor":"Admin"} with an unverified account.\n"
                                                                      "Please verify first with the link sent to your email.",
                                                                      textAlign: TextAlign.center,
                                                                      style:TextStyle(
                                                                        fontSize: mqh*0.02,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:mqh*0.015,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.all(mqw*0.02),
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.green[800],
                                                                        borderRadius: BorderRadius.all(Radius.circular(mqh*0.01))
                                                                      ),
                                                                      child: GestureDetector(
                                                                        onTap: () async {
                                                                          await user.sendEmailVerification();
                                                                          FirebaseAuth.instance.signOut();
                                                                          Navigator.of(context).pop();
                                                                          setState(() {
                                                                            _check = false;
                                                                          });
                                                                        },
                                                                        child: Text(
                                                                          "Okay!",
                                                                          textAlign: TextAlign.center,
                                                                          style:TextStyle(
                                                                            fontSize: mqh*0.02,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                            }
                                                            else{
                                                              Navigator.of(context).pop();
                                                              alertBox(
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons.done, 
                                                                      color: Colors.green.shade500,
                                                                      size: mqh*0.04
                                                                    ),
                                                                    SizedBox(
                                                                      height:mqh*0.035,
                                                                    ),
                                                                    Text(
                                                                      "${(role==1)?"Doctor":"Admin"} Login\n$email",
                                                                      textAlign: TextAlign.center,
                                                                      style:TextStyle(
                                                                        fontSize: mqh*0.02,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              );
                                                              Future.delayed(const Duration(seconds: 2), () {
                                                                Navigator.push(
                                                                  context, PageTransition(
                                                                    type: PageTransitionType.rightToLeft, 
                                                                    duration: const Duration(milliseconds: 400),
                                                                    child: (role==1)?const DoctorHome():const AdminHome(),
                                                                  )
                                                                );
                                                              });
                                                            }
                                                          }
                                                        }
                                                        else{
                                                          setState((){
                                                              role = -1;
                                                          });
                                                        }
                                                      });
                                                    }on FirebaseAuthException catch (e){
                                                      Navigator.of(context).pop();
                                                      setState((){
                                                        _check = !_check;
                                                      });
                                                      String msg;
                                                      if(e.code == 'user-not-found'){
                                                        msg = 'No Such User found!';
                                                      }else if(e.code == 'wrong-password'){
                                                        msg = 'Incorrect Password !';
                                                      }else{
                                                        msg = 'Something went wrong!';
                                                      }
                                                      ScaffoldMessenger.of(context).showSnackBar(snackBar(msg));
                                                      
                                                    }
                                                    setState((){
                                                      _check = !_check;
                                                    });
                                                  }
                                                  
                                                }
                                                
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
                                                  "Sign In",
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
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed:(){
                                              setState((){
                                                _check = !_check;
                                              });
                                              showDialog(
                                                context: context,
                                                builder:  (BuildContext context)
                                                {
                                                  return AlertDialog(
                                                    title: const Text(
                                                      'Reset Password',
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(mqh*0.025),
                                                    ), 
                                                    backgroundColor: Colors.green[100],
                                                    content: SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          const Text(
                                                            'Enter username to reset password:',
                                                            textAlign: TextAlign.left,
                                                          ),
                                                          SizedBox(
                                                            height:mqh*0.02
                                                          ),
                                                          Form(
                                                            key: formKeyReset,
                                                            child: TextFormField(
                                                              inputFormatters: <TextInputFormatter>[
                                                                FilteringTextInputFormatter.allow(RegExp("[a-z0-9.-]")),
                                                              ],
                                                              decoration: const InputDecoration(
                                                                hintText: "Username",
                                                              ),
                                                              validator: (value){
                                                                if(value!.isEmpty){
                                                                  return "Username can't be Empty!";
                                                                }
                                                                return null;
                                                              },
                                                              onChanged: (value){
                                                                value = value.replaceAll(' ', '');
                                                                emailReset = value + "@lnmiit.ac.in";
                                                                setState(() {
                                                                  
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        child: const Text(
                                                          'Send Reset Password Link', 
                                                          style: TextStyle(color:Colors.black)
                                                        ),
                                                        onPressed: () {
                                                          
                                                        },
                                                      ),
                                                      TextButton(
                                                          child: const Text('Cancel', 
                                                          style: TextStyle(color:Colors.black)
                                                        ),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child:Text(
                                            "Forgot Password ?",
                                              style:TextStyle(
                                                fontSize: mqh*0.023,
                                                color: Colors.black87,
                                              ),
                                            )
                                          ),
                                        ),
                                        SizedBox(
                                          height:mqh*0.04
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: const Text(
                                            "Don't have an account ?",
                                          ),
                                        ),
                                        SizedBox(
                                          height:mqh*0.01
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Material(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(mqw*0.03),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context, PageTransition(
                                                    type: PageTransitionType.bottomToTop, 
                                                    duration: const Duration(milliseconds: 400),
                                                    child: const Register()
                                                  )
                                                );
                                              },
                                              child: Container(
                                                width: mqw*0.39,
                                                height: mqw*0.125,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Sign Up Now",
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
                                      ],
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