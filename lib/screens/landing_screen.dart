// ignore_for_file: must_be_immutable

import 'package:eco_store/screens/bottom_navbar.dart';
import 'package:eco_store/screens/login_screen.dart';
import 'package:eco_store/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  LandingScreen({super.key});
  Future<FirebaseApp> initialize = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initialize,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('${streamSnapshot.error}'),
                  ),
                );
              }
              if (streamSnapshot.connectionState == ConnectionState.active) {
                User? user = streamSnapshot.data;
                if (user == null) {
                  return const LoginScreen();
                } else {
                  return const BottomNavBarScreen();
                }
              }
              return const Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'CHECKING\nAUTHENTICATION',
                        textAlign: TextAlign.center,
                        style: MyStyle.boldstyle,
                      ),
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }

        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'INITIALIZATION',
                  style: MyStyle.boldstyle,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
