import 'dart:core';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String emailReset = "";
  String password = "";

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
        backgroundColor: Colors.blue[400],
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
                            color: Colors.blue[200],
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
                                  color: Colors.lightBlue[100],
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
                                          "(can include only lowercase letters, '.' and '-')",
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
                                            color: (_check1 == true)?Colors.blue[300]:Colors.blue,
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
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed:(){
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
                                                    backgroundColor: Colors.blue[100],
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
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(mqw*0.03),
                                            child: InkWell(
                                              onTap: () {
                                                
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