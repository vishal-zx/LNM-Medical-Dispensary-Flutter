import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lnm_medical_dispensary/pages/login.dart';
import 'package:lnm_medical_dispensary/pages/patient/home.dart';
import 'package:lnm_medical_dispensary/pages/register.dart';
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
        primarySwatch:const MaterialColor(
          0xFF000000, {
            50:  Color(0x00000000),
            100: Color(0x00000000),
            200: Color(0x00000000),
            300: Color(0x00000000),
            400: Color(0x00000000),
            500: Color(0x00000000),
            600: Color(0x00000000),
            700: Color(0x00000000),
            800: Color(0x00000000),
            900: Color(0x00000000),
          }
        ),
        fontFamily: 'Avenir',
      ),
      title: 'LNM Medical Dispensary',

      routes: {
        MyRoutes.loginRoute: (context) => const Login(),
        MyRoutes.registerRoute: (context) => const Register(),
        MyRoutes.patHomeRoute: (context) => const PatientHome(),
      },
    );
  }
}