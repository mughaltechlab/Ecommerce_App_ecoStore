import 'package:eco_store/widgets/mybtn.dart';
import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final String? msg;
  const MyAlertBox({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(msg!),
      actions: [
        MyButton(
          btnName: 'CLOSE',
          btnColor: Colors.red.shade200,
          btnNameColor: Colors.black,
          btnFunc: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
