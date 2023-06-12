// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  // final IconData? icon;
  final String? hintText;
  Widget? icon;
  bool obscuretxt;
  TextEditingController? controller;
  String? Function(String?)? validate;
  TextInputAction? inputAction;
  FocusNode? focusNode;
  int? maxLines;

  MyTextField({
    super.key,
    this.hintText,
    this.icon,
    this.obscuretxt = false,
    this.controller,
    this.validate,
    this.inputAction,
    this.focusNode,
    this.maxLines,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 65,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.shade400,
      ),
      child: TextFormField(
        // maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        controller: widget.controller,
        validator: widget.validate,
        textInputAction: widget.inputAction,
        obscureText: widget.obscuretxt == false ? false : widget.obscuretxt,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: widget.icon,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              fontSize: 18,
              letterSpacing: 1.5,
            ),
            contentPadding: const EdgeInsets.all(20)),
      ),
    );
  }
}
