// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../util/styles.dart';

class Header extends StatelessWidget {
  String? title;
  Header({
    super.key,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple.shade200,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title!,
        style: MyStyle.boldstyle.copyWith(
          fontSize: 20,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}
