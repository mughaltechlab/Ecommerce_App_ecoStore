// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnName;
  final Color btnColor;
  final Color btnNameColor;
  final VoidCallback? btnFunc;
  bool? isLoading;

  MyButton({
    super.key,
    required this.btnName,
    required this.btnColor,
    required this.btnNameColor,
    this.btnFunc,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: btnFunc,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: btnColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            )),
        child: Stack(children: [
          // button
          Visibility(
            visible: isLoading! ? false : true,
            child: Center(
              child: Text(
                btnName,
                style: TextStyle(
                  color: btnNameColor,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),

          // loading indicator
          Visibility(
            visible: isLoading!,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ]),
      ),
    );
  }
}
