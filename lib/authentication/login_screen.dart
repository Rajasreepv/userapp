// import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:user_app/authentication/signup_screen.dart';
import 'package:user_app/global/global.dart';
import 'package:user_app/mainscreens/mainscreen.dart';

_normalProgress(context) async {
  ProgressDialog pd = ProgressDialog(context: context);
  pd.show(
      msg: 'Processing please wait...',
      progressBgColor: Colors.transparent,
      backgroundColor: Colors.white,
      msgColor: Color.fromARGB(255, 5, 71, 65),
      progressValueColor: Colors.purple);
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController EmailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  loginvalidation() {
    if (!EmailEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email format wrong!!");
    } else if (passwordEditingController.text.length < 5) {
      Fluttertoast.showToast(msg: "password must be atleast 6 characters long");
    } else {
      loginCheck();
      // Navigator.push(context, MaterialPageRoute(builder: (c) => home()));
    }
  }

  loginCheck() async {
    _normalProgress(context);
    final User? firebaseUser = (await fAuth.signInWithEmailAndPassword(
            email: EmailEditingController.text.trim(),
            password: passwordEditingController.text.trim())
        // ignore: body_might_complete_normally_catch_error
        )
        .user;
    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Login Successfull");

      Navigator.push(context, MaterialPageRoute(builder: (c) => mainpage()));
    } else {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Error Login!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(208, 191, 255, 1),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                children: [
                  // Image.asset("images/logo2.png"),
                  const SizedBox(height: 30),
                  const Text(
                    "Login as a User ",
                    style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 5, 71, 65),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: EmailEditingController,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                  TextFormField(
                    controller: passwordEditingController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: ElevatedButton(
                        onPressed: () {
                          loginvalidation();
                        },
                        child: const Text("Login")),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => signupscreen()));
                      },
                      child: const Text(
                        "Dont have an Account ? Register Here",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
