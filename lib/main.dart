import 'package:flutter/material.dart';
import 'package:loan_calculator/register.dart';
import 'splash.dart';
import 'login.dart';
import 'package:loan_calculator/Resultpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';



void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      "/":(context) => Splash(),
  "/login":(context) => Login(),
      "/calculator":(context) => LoanCalculatorPage(),
      "/register":(context)=> RegistrationScreen(),
      // '/result': (context) => LoanCalculatorPage(),
    },
  ));
}
