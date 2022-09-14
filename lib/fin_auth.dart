// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures
 
import 'package:fin_info_com/screens/fin_home_screen.dart';
import 'package:fin_info_com/screens/fin_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else
            return LoginPage();
        });
  }
}
