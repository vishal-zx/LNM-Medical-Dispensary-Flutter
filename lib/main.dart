import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lnm_medical_dispensary/pages/login.dart';
import 'package:lnm_medical_dispensary/utils/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

String route = MyRoutes.loginRoute;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _initialized = false;
  bool _error = false;
  
  void initializeFlutterFire() async {
    try {      
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {      
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    if(_error) {
      return Container();
    }

    if (!_initialized) {
      return Container();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: MyRoutes.loginRoute,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        fontFamily: 'Avenir',
      ),
      title: 'LNM Medical Dispensary',
      routes: {
        MyRoutes.loginRoute: (context) => const Login(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static String userName = "";

  @override
  Widget build(BuildContext context) {
    CollectionReference tst = FirebaseFirestore.instance.collection('testing');
    return FutureBuilder<DocumentSnapshot>(
      future: tst.doc('check1').get(const GetOptions(source: Source.serverAndCache)),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong!");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("User does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          userName = data['name'];
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    userName,
                  ),
                ],
              ),
            ),
          );
        }

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
          child: const SpinKitCircle(
            color: Colors.grey,
            size: 55.0,
          ),
        );
      }
    );
  }
}
