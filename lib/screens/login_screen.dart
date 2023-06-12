// ignore_for_file: must_be_immutable

import 'package:eco_store/screens/bottombar_screens/home_screen.dart';
import 'package:eco_store/screens/signup_screen.dart';
import 'package:eco_store/widgets/my_textfield.dart';
import 'package:eco_store/widgets/mybtn.dart';
import 'package:flutter/material.dart';
import 'package:eco_store/util/styles.dart';

import '../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  bool obscuretxt = true;
  bool? formstateLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
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

  // login function
  submit() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        formstateLoading = true;
      });
      String? accountStatus =
          await FirebaseServices.logInAccount(emailC.text, passwordC.text);
      if (accountStatus != null) {
        myDialogBox(accountStatus);

        setState(() {
          formstateLoading = false;
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
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
                  'Welcome\nPlease Login First',
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
                                !v.contains('.com')) {
                              return 'input correct email please';
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
                              return "enter password";
                            }
                            return null;
                          },
                          controller: passwordC,
                          obscuretxt: obscuretxt,
                          inputAction: TextInputAction.next,
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

                        // login buttons
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: MyButton(
                            btnName: 'LOGIN',
                            isLoading: formstateLoading!,
                            btnColor: Colors.deepPurpleAccent,
                            btnNameColor: Colors.white,
                            btnFunc: () {
                              submit();
                            },
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

                        const SizedBox(height: 200),

                        const Text(
                          "You haven't account?",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),

                        // signup btn
                        MyButton(
                          btnName: 'CREATE NEW ACCOUNT',
                          btnColor: Colors.deepPurple,
                          btnNameColor: Colors.white,
                          btnFunc: () {
                            final route = MaterialPageRoute(
                                builder: (_) => const SignupScreen());
                            Navigator.push(context, route);
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
