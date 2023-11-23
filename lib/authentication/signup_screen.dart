// import 'dart:html';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:user_app/authentication/login_screen.dart';
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

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  //   progress dialog

  TextEditingController nameEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

//formvalidation

  validation() {
    if (nameEditingController.text.length <= 2 ||
        nameEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Name should be atleast 3 characters");
    } else if (!emailEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "email format wrong!!");
    } else if (phoneEditingController.text.length < 10 ||
        phoneEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Mobile number should be 10 digits");
    } else if (passwordEditingController.text.length < 5) {
      Fluttertoast.showToast(msg: "password must be atleast 6 characters long");
    } else {
      saveDriverInfo();
    }
  }

//storing driverInfo
  saveDriverInfo() async {
    _normalProgress(context);
    final User? firebaseUser = (await fAuth.createUserWithEmailAndPassword(
            email: emailEditingController.text.trim(),
            password: passwordEditingController.text.trim())
        // ignore: body_might_complete_normally_catch_error
        )
        .user;

    ///////
    ///
    ///
    ///
    ///
    ///
    if (firebaseUser != null) {
      Map usersMap = {
        "id": firebaseUser.uid,
        "name": nameEditingController.text.trim(),
        "email": emailEditingController.text.trim(),
        "phone": phoneEditingController.text.trim()
      };
      DatabaseReference driversref =
          FirebaseDatabase.instance.ref().child("users");
      driversref.child(firebaseUser.uid).set(usersMap);
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account created Successfully");

      Navigator.push(context, MaterialPageRoute(builder: (c) => mainpage()));
    }
    ///////
    ////
    ///
    ///
    ///
    else {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: "Account not created!");
    }
  }

  ////////
  ///
  ///
  ///
  ///
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
                    "Register as a User ",
                    style: TextStyle(
                        fontSize: 26,
                        color: Color.fromARGB(255, 5, 71, 65),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: nameEditingController,
                    decoration: const InputDecoration(
                        labelText: "Name",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailEditingController,
                    decoration: const InputDecoration(
                        hintText: "abc@gmail.com",
                        labelText: "Email",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(color: Colors.white, fontSize: 10),
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    controller: phoneEditingController,
                    decoration: const InputDecoration(
                        labelText: "Phone",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
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
                          validation();
                        },
                        child: const Text("Create Account")),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (c) => Login()));
                      },
                      child: const Text(
                        "Already have an Account ? Login Here",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
