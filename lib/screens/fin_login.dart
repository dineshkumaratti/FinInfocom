// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures, unnecessary_string_interpolations

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'fin_home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController(text: 'Fininfocom');
  TextEditingController password = TextEditingController(text: 'Fin@123');
  var signupkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Form(
      key: signupkey,
      child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Center(
                child: Text(
                  'Welcome To FinInfocom',
                  style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),
                ),
              ),
              SizedBox(
                height: screenHeight * .05,
              ),
              TextFormField(
                controller: username,
                decoration: InputDecoration(
                    labelText: 'User Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username required';
                  } else if (value.length != 10) {
                    return 'username must be 10 charecters ';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: screenHeight * .05,
              ),
              TextFormField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password required';
                    } else if (value.length < 6)
                      return 'Password should contain atleast 6 characters';
                    return null;
                  }),
              SizedBox(
                height: screenHeight * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * .05,
                    width: screenWidth * .4,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (signupkey.currentState!.validate()) {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: '${username.text}@gmail.com',
                                  password: password.text)
                              .then((value) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          }).onError((error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('${error.toString()}')));
                            print(error.toString());
                          });
                        }
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
            ],
          )),
    );
  }
}
