import 'dart:core';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'patient/home.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  const Register({ Key? key }) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class User{
  String username;
  String email;
  String fName;
  String lName;
  bool isMale;
  String password;
  String speciality;
  String mob;
  String age;

  User(this.username, this.email, this.fName, this.lName, this.isMale, this.password, this.speciality, this.mob, this.age);
}

class _RegisterState extends State<Register> {
  String username = "";
  String email = "";
  String fName = "";
  String lName = "";
  int idx = 0;
  bool isMale = true;
  String password = "";
  String speciality = "";
  String mob = "";
  String age = "";
  List<String> roles = ["Patient", "Doctor", "Admin"];  
  final formKey = GlobalKey<FormState>(); 
  bool _showPass = true;
  bool _check = false;
  bool _check1 = false;
  bool reg = false;

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
    else{
      setState(() {
        _check1 = false;
      });
    }
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

  Future<void> patReg(User user) async {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    try{
      QuerySnapshot qs = await FirebaseFirestore.instance.collection('patient').where('Email', isEqualTo: email).get();
      var patients = qs.docs;
      if(patients.isNotEmpty){
        setState((){
          _check = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(snackBar('Account already exists !!'));
      }else{
        showDialog(
          barrierDismissible: false,
          context: context, 
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                backgroundColor: Colors.brown.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mqw*0.03)),
                insetPadding: EdgeInsets.only(left:mqw*0.15),
                content: Container(
                  alignment: Alignment.center,
                  width:mqw*0.5,
                  height:mqh*0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:mqw*0.1,
                        width:mqw*0.1,
                        child: const CircularProgressIndicator(
                          color: Colors.brown,
                        ),
                      ),
                      SizedBox(
                        height:mqh*0.035,
                      ),
                      Text(
                        "Registering your account..\nPlease wait..",
                        textAlign: TextAlign.center,
                        style:TextStyle(
                          fontSize: mqh*0.02,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        );
        try{
          await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password).then((value) async{
            await FirebaseFirestore.instance.collection('patient').doc(user.username).set(
              {
                'FirstName': user.fName,
                'LastName': user.lName,
                'Username': user.username,
                'Email': user.email,
                'Mob': user.mob,
                'Age': user.age,
                'isMale': user.isMale,
              }
            ).then((value){
              setState(() {
                reg = true;
              });
            });
          });
        }on FirebaseAuthException catch(e)
          {
            if (e.code == 'weak-password') {
              setState((){
                _check = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(snackBar('The password provided is too weak.'));
            }
          }
      }
    }on FirebaseAuthException {
      setState((){
        _check = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar('Something went wrong! Please try again.'));
    }
  }

  final PageController _pageController = PageController(
    viewportFraction: 0.5,
    keepPage: true
  );

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        FocusManager.instance.primaryFocus?.unfocus();
        check(context);
      },
      child: Scaffold(
        backgroundColor: Colors.brown[400],
        body: SafeArea(
          child: SingleChildScrollView(
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
                                alignment: Alignment.centerRight,
                                width: mqw*0.85,
                                height: mqh*0.75,
                                child: SizedBox(
                                  width: mqw*0.8,
                                  height: mqh*0.7,
                                  child:Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(), 
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Choose Your Role",
                                                  style:TextStyle(
                                                    fontSize: mqh*0.028,
                                                    color: Colors.black87,
                                                  )
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      padding: const EdgeInsets.all(0),
                                                      onPressed: () {
                                                        if(idx>0){
                                                          setState(() {
                                                            idx--;
                                                            _pageController.previousPage(duration: const Duration(milliseconds: 250), curve: Curves.linear);
                                                          });
                                                        }
                                                      },
                                                      icon:(idx==0)?
                                                        const Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Colors.grey,
                                                        ):
                                                        const Icon(
                                                          Icons.arrow_back_ios
                                                        )
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(mqw*0.03),
                                                      width:mqw*0.5,
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          stops: const [0.0, 0.5, 1.0],
                                                          colors: [Colors.brown.shade50, Colors.brown.shade100.withOpacity(0.6), Colors.brown.shade50],
                                                          begin: Alignment.centerLeft,
                                                          end: Alignment.centerRight,
                                                        ),
                                                        borderRadius: BorderRadius.all(Radius.circular(mqh*0.02),
                                                        )
                                                      ),
                                                      child: SizedBox(
                                                        height:mqh*0.035,
                                                        width:mqw*0.42,
                                                        child: PageView.builder(
                                                          itemCount: 3,
                                                          controller: _pageController,
                                                          physics: const BouncingScrollPhysics(),
                                                          onPageChanged: (int index) => setState(() {idx=index;}),
                                                          itemBuilder: (context, i){
                                                            return Transform.scale(
                                                              scale: (i==idx)?1:1,
                                                              child: Center(
                                                                child: Text(
                                                                  roles[i],
                                                                  style:TextStyle(
                                                                    fontWeight: (i==idx)?FontWeight.bold:FontWeight.normal,
                                                                    fontSize: mqh*0.025,
                                                                    color: (i==idx)?Colors.black:Colors.black45,
                                                                  )
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        ),
                                                      ),
                                                    ),
                                                    IconButton(
                                                      padding: const EdgeInsets.all(0),
                                                      onPressed: () {
                                                        if(idx<2){
                                                          setState(() {
                                                            idx++;
                                                            _pageController.nextPage(duration: const Duration(milliseconds: 250), curve: Curves.linear);
                                                          });
                                                        }
                                                      },
                                                      icon:(idx==2)?
                                                        const Icon(
                                                          Icons.arrow_forward_ios,
                                                          color: Colors.grey,
                                                        ):
                                                        const Icon(
                                                          Icons.arrow_forward_ios
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height:mqh*0.04
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left:mqw*0.02,right:mqw*0.08),
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
                                                    hintText: "Enter your email",
                                                    suffixText: "@lnmiit.ac.in",
                                                  ),
                                                  validator: (value){
                                                    if(value!.isEmpty){
                                                      return "Email can't be empty!";
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
                                                  height:mqh*0.04
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
                                                  height:mqh*0.04
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
                                                      return "First name can't be empty!";
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
                                                  height:mqh*0.04
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
                                                      return "Last name can't be empty!";
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
                                                  height:mqh*0.04
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
                                                    if(value!.isEmpty){return "Password can't be empty!";}
                                                    else if(value.length<6){return "Password must be greater than 6 characters.";}
                                                    else {return null;}
                                                  },
                                                  onChanged: (value){
                                                    password = value;
                                                    setState(() {
                                                      
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  height:mqh*0.04
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
                                                  validator: (value){
                                                    if(value!.isEmpty){return "Mobile number can't be empty!";}
                                                    else {return null;}
                                                  },
                                                  onChanged:(value){
                                                    mob = value;
                                                  }
                                                ),
                                                SizedBox(
                                                  height:mqh*0.04
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
                                                  validator: (value){
                                                    if(value!.isEmpty){return "Age can't be empty!";}
                                                    else {return null;}
                                                  },
                                                  onChanged:(value){
                                                    age = value;
                                                  }
                                                ),
                                                SizedBox(
                                                  height:mqh*0.04
                                                ),
                                                if(idx==1)
                                                Text(
                                                  "Speciality",
                                                  style:TextStyle(
                                                    fontSize: mqh*0.035,
                                                    color: Colors.black87,
                                                  )
                                                ),
                                                if(idx==1)
                                                TextFormField(
                                                  decoration: const InputDecoration(
                                                    hintText: "Enter your speciality",
                                                  ),
                                                  validator: (value){
                                                    if(value!.isEmpty){
                                                      return "Speciality can't be Empty!";
                                                    }
                                                    return null;
                                                  },
                                                  onChanged: (value){
                                                    speciality = value;
                                                    setState(() {
                                                      
                                                    });
                                                  },
                                                ),
                                                if(idx==1)
                                                SizedBox(
                                                  height:mqh*0.04
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
                                                  height:mqh*0.04
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Material(
                                              color: (_check == true)?Colors.brown[300]:Colors.brown,
                                              borderRadius: BorderRadius.circular(_check?mqw*0.1:mqw*0.03),
                                              child: InkWell(
                                                onTap: () async{
                                                  check(context);
                                                  if(_check1 && !_check){
                                                    User user = User(username, email, fName, lName, isMale, password, speciality, mob, age);
                                                    _check=!_check;
                                                    if(idx == 0){
                                                      await patReg(user).whenComplete((){
                                                        if (reg) {
                                                          Navigator.of(context).pop();
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context, 
                                                            builder: (BuildContext context) {
                                                              return WillPopScope(
                                                                onWillPop: () async => false,
                                                                child: AlertDialog(
                                                                  backgroundColor: Colors.brown.shade100,
                                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(mqw*0.03)),
                                                                  insetPadding: EdgeInsets.only(left:mqw*0.15),
                                                                  content: Container(
                                                                    alignment: Alignment.center,
                                                                    width:mqw*0.5,
                                                                    height:mqh*0.17,
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons.done, 
                                                                          color: Colors.brown.shade500,
                                                                          size: mqh*0.04
                                                                        ),
                                                                        SizedBox(
                                                                          height:mqh*0.02,
                                                                        ),
                                                                        Text(
                                                                          "Account Registered Successfully\nLogging in as ${user.email}",
                                                                          textAlign: TextAlign.center,
                                                                          style:TextStyle(
                                                                            fontSize: mqh*0.02,
                                                                            color: Colors.black,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                          Future.delayed(const Duration(seconds: 3), () {
                                                            Navigator.push(
                                                              context, 
                                                              PageTransition(
                                                                type: PageTransitionType.rightToLeft, 
                                                                duration: const Duration(milliseconds: 400),
                                                                child: const PatientHome()
                                                              )
                                                            );
                                                          });
                                                        }
                                                      });
                                                    }
                                                  }
                                                },
                                                child: AnimatedContainer(
                                                  duration: _check? const Duration(milliseconds: 600):const Duration(seconds: 0),
                                                  width: _check?mqw*0.125: mqw*0.3,
                                                  height: mqw*0.125,
                                                  alignment: Alignment.center,
                                                  child: _check?
                                                  const Icon(
                                                    Icons.done, 
                                                    color: Colors.white,
                                                  ):
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
                                            height:mqh*0.005
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            child: Material(
                                              color:Colors.brown,
                                              borderRadius: BorderRadius.circular(mqw*0.03),
                                              child: InkWell(
                                                onTap: () {
                                                  setState((){
                                                    Navigator.push(
                                                      context, 
                                                      PageTransition(
                                                        type: PageTransitionType.rightToLeft, 
                                                        duration: const Duration(milliseconds: 400),
                                                        child: const PatientHome()
                                                      )
                                                    );
                                                  });
                                                },
                                                child: AnimatedContainer(
                                                  duration: const Duration(seconds: 1),
                                                  width: mqw*0.3,
                                                  height: mqw*0.125,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "Patient",
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