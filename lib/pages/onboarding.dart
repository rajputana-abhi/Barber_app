import 'dart:async';

import 'package:barber_app/pages/home.dart';
import 'package:barber_app/pages/login.dart';
import 'package:flutter/material.dart';

class onboarding extends StatefulWidget {
  const onboarding({super.key});

  @override
  State<onboarding> createState() => _onboardingState();
}

class _onboardingState extends State<onboarding> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
          margin: EdgeInsets.only(top: 150),
          child: Column(
            children: [
              Container(
                  height: 400,
                  width: 5000,
                  child: Image.asset("images/barber.png")),
              SizedBox(
                height: 80,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(255, 248, 162, 96),
                ),
                child: Text(
                  "Get a Stylish Haircut",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }
}
