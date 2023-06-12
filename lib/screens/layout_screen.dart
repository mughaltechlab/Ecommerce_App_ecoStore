import 'package:eco_store/screens/landing_screen.dart';
import 'package:eco_store/screens/web_side/admin_login.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.minWidth > 600) {
          return const AdminLogin();
        } else {
          return LandingScreen();
        }
      },
    );
  }
}
