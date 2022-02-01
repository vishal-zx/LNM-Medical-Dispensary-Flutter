import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({ Key? key }) : super(key: key);

  @override
  PatientProfileState createState() => PatientProfileState();
}

class PatientProfileState extends State<PatientProfile> {
  final formKey = GlobalKey<FormState>();
  bool _check1 = false;
  String fName = "";
  String lName = "";
  bool isMale = true;
  String mob = "";
  String age = "";
  bool isLoaded = false;
  String email = FirebaseAuth.instance.currentUser!.email!;
  String username = FirebaseAuth.instance.currentUser!.email!.replaceAll('@lnmiit.ac.in', '');

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

  Future<void> getPatDetails()async{
    QuerySnapshot qsP = await FirebaseFirestore.instance.collection('patient').where('Username', isEqualTo:username).get();
    var data = qsP.docs[0].data() as Map<String, dynamic>;
    setState(() {
      fName = data['FirstName']! as String;
      lName = data['LastName']! as String;
      isMale = data['isMale']! as bool;
      mob = data['Mob']! as String;
      age = data['Age']! as String;
    });
    setState(() {});
  }

  @override
  void initState(){
    getPatDetails().whenComplete(() => setState((){isLoaded = true;}));
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
                              child: (!isLoaded)?Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height:mqw*0.1,
                                    width:mqw*0.1,
                                    child: CircularProgressIndicator(
                                      color: Colors.amber.shade800,
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
                                    Text(
                                      "Email",
                                      style:TextStyle(
                                        fontSize: mqh*0.035,
                                        color: Colors.black87,
                                      )
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      initialValue: email,
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
                                      initialValue: username,
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
                                      initialValue: fName,
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
                                      initialValue: lName,
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
                                      initialValue: mob,
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
                                      initialValue: age,
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
                                          color: isMale?Colors.orange[900]:Colors.orange[300],
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
                                          color: isMale?Colors.orange[300]:Colors.orange[900],
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
                                        borderRadius: BorderRadius.circular(_check1?mqw*0.1:mqw*0.03),
                                        child: InkWell(
                                          onTap: () async{
                                            if(!_check1){
                                              if(fName=='' || lName == '' || age == '' || mob == '')
                                              {
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar('Please fill all the details !'));
                                              }
                                              else{
                                                print("$username us");
                                                setState(() {_check1 = true;});
                                                await FirebaseFirestore.instance.collection('patient').doc(username).update({
                                                  'FirstName': fName,
                                                  'LastName': lName,
                                                  'Mob': mob,
                                                  'Age': age,
                                                  'isMale': isMale,
                                                }).whenComplete(() => setState(() {
                                                  Navigator.of(context).pop();
                                                  ScaffoldMessenger.of(context).showSnackBar(snackBar('Profile Updated Successfully !'));
                                                }));
                                              }
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