// ignore_for_file: unnecessary_null_comparison

import 'package:eco_store/screens/web_side/admin_pannel.dart';
import 'package:eco_store/services/firebase_services.dart';
import 'package:eco_store/util/styles.dart';
import 'package:eco_store/widgets/my_alert_dialog.dart';
import 'package:eco_store/widgets/my_textfield.dart';
import 'package:eco_store/widgets/mybtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdminLogin extends StatefulWidget {
  static const String id = "adminlogin";
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController usernameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  bool obscuretxt = true;

  bool? formstateLoading = false;

  final formKey = GlobalKey<FormState>();

  // admin login anonymously
  nav() {
    Navigator.pushReplacementNamed(context, AdminPannel.id);
  }

  // Admin Login function
  submit() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formstateLoading = true;
      });
      await FirebaseServices.adminLogin(usernameC.text).then((value) async {
        if (value['username'] == usernameC.text &&
            value['password'] == passwordC.text) {
          // for anonymous sign in
          try {
            UserCredential user =
                await FirebaseAuth.instance.signInAnonymously();
            if (user != null) {
              return nav();
              // Navigator.pushReplacementNamed(context, AdminPannel.id);
            }
          } catch (e) {
            setState(() {
              formstateLoading = false;
            });
            return showDialog(
                context: context,
                builder: (_) => MyAlertBox(
                      msg: e.toString(),
                    ));
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Form(
          key: formKey,
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.shade100.withOpacity(.5),
                      blurRadius: 2,
                      // spreadRadius: 5,
                    ),
                    BoxShadow(
                      color: Colors.yellow.shade100.withOpacity(.3),
                      blurRadius: 10,
                      spreadRadius: 10,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                  // border: Border.all(color: Colors.purple, width: 3),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "WELCOME ADMIN",
                      style: MyStyle.boldstyle.copyWith(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    Text(
                      "Log in to your account",
                      style: MyStyle.boldstyle.copyWith(),
                    ),
                    MyTextField(
                        hintText: "Enter Admin Email",
                        controller: usernameC,
                        validate: (v) {
                          if (v!.isEmpty) {
                            return 'input correct email please';
                          }
                          return null;
                        },
                        obscuretxt: false,
                        icon: const Icon(Icons.email_outlined)),
                    MyTextField(
                      hintText: "Enter Admin Password",
                      validate: (v) {
                        if (v!.isEmpty) {
                          return 'please insert your password';
                        }
                        return null;
                      },
                      controller: passwordC,
                      obscuretxt: obscuretxt,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscuretxt = !obscuretxt;
                          });
                        },
                        icon: obscuretxt
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility),
                      ),
                    ),

                    // button
                    MyButton(
                      btnName: 'LOGIN',
                      btnColor: Colors.black,
                      btnNameColor: Colors.white,
                      isLoading: formstateLoading,
                      btnFunc: () {
                        submit();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
