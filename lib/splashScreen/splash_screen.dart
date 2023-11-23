import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_app/authentication/login_screen.dart';
import 'package:user_app/global/global.dart';

import 'package:user_app/mainscreens/mainscreen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 13), () async {
      if (await fAuth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (c) => mainpage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Login()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          color: Color.fromRGBO(190, 173, 250, 1),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "images/taxidriver.png",
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "UserApp",
                style: TextStyle(
                    color: Color.fromRGBO(255, 243, 218, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )
            ],
          )),
        ),
      ),
    );
  }
}
