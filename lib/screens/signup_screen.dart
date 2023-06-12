// ignore_for_file: use_build_context_synchronously

import 'package:eco_store/screens/login_screen.dart';
import 'package:eco_store/services/firebase_services.dart';
import 'package:eco_store/widgets/my_textfield.dart';
import 'package:eco_store/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:eco_store/util/styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();

  TextEditingController retypePasswordC = TextEditingController();

  bool obscuretxt = true, obscuretxt2 = true;

  final formKey = GlobalKey<FormState>();

  bool? formstateLoading = false;

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    retypePasswordC.dispose();
    super.dispose();
  }

  // error dialog box
  myDialogBox(String? error) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error!),
            actions: [
              MyButton(
                btnName: 'CLOSE',
                btnColor: Colors.red.shade200,
                btnNameColor: Colors.black,
                btnFunc: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }

  // success dialog box
  successDialogBox(String? success) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(success!),
            actions: [
              MyButton(
                btnName: 'LOGIN NOW',
                btnColor: Colors.green.shade200,
                btnNameColor: Colors.black,
                btnFunc: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const LoginScreen())),
              ),
            ],
          );
        });
  }

  // singnup function
  submit() async {
    if (formKey.currentState!.validate()) {
      if (passwordC.text == retypePasswordC.text) {
        setState(() {
          formstateLoading = true;
        });
        String? accountStatus =
            await FirebaseServices.createAccount(emailC.text, passwordC.text);
        if (accountStatus != null) {
          myDialogBox(accountStatus);

          setState(() {
            formstateLoading = false;
          });
        } else {
          successDialogBox("Successfully Registered");
          // Navigator.pop(context);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // welcome heading
              const Center(
                child: Text(
                  'Please\nCreate Your Account',
                  textAlign: TextAlign.center,
                  style: MyStyle.boldstyle,
                ),
              ),

              //form textfields buttons
              Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // email
                        MyTextField(
                          hintText: 'Email',
                          validate: (v) {
                            if (v!.isEmpty ||
                                !v.contains('@') ||
                                !v.contains('com')) {
                              return 'enter correct email';
                            }
                            return null;
                          },
                          controller: emailC,
                          inputAction: TextInputAction.next,
                          obscuretxt: false,
                          icon: const Icon(Icons.mail_rounded),
                        ),
                        MyTextField(
                          hintText: 'Password',
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'enter your password';
                            }
                            return null;
                          },
                          controller: passwordC,
                          inputAction: TextInputAction.next,
                          obscuretxt: obscuretxt,
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscuretxt = !obscuretxt;
                              });
                            },
                            icon: obscuretxt
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),
                        MyTextField(
                          hintText: 'Retype Password',
                          validate: (v) {
                            if (v!.isEmpty) {
                              return 'enter your password';
                            }
                            return null;
                          },
                          controller: retypePasswordC,
                          obscuretxt: obscuretxt2,
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscuretxt2 = !obscuretxt2;
                              });
                            },
                            icon: obscuretxt2
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          ),
                        ),

                        // login buttons
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: MyButton(
                            btnName: 'SIGNUP',
                            btnColor: Colors.deepPurpleAccent,
                            btnNameColor: Colors.white,
                            btnFunc: submit,
                            isLoading: formstateLoading!,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(17.0),
                          child: Divider(
                            color: Colors.grey,
                            height: 5,
                            thickness: 1,
                          ),
                        ),

                        const Text(
                          "You haven an account?",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),

                        // signup btn
                        MyButton(
                          btnName: 'BACK TO LOGIN',
                          btnColor: Colors.deepPurple,
                          btnNameColor: Colors.white,
                          btnFunc: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ), //form
            ],
          ),
        ),
      ),
    );
  }
}
