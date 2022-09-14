 import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'fin_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyDyJf6Pc8wnycai9K__UQsC977cg1UtKVk",
        authDomain: "fininfocom-57925.firebaseapp.com",
        projectId: "fininfocom-57925",
        storageBucket: "fininfocom-57925.appspot.com",
        messagingSenderId: "982341053537",
        appId: "1:982341053537:web:55da008bca5253071d8e20",
        measurementId: "G-P880WWG6T5"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          brightness: Brightness.dark),
      home: const Scaffold(
        body: Authentication(),
      ),
    );
  }
}
