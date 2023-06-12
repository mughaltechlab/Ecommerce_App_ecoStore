import 'package:flutter/material.dart';

import '../util/styles.dart';

class HomeCards extends StatelessWidget {
  final String? title;
  const HomeCards({
    this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Colors.redAccent.withOpacity(.4),
            Colors.lightBlueAccent.withOpacity(1),
            Colors.redAccent.withOpacity(.4),
          ]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              title ?? 'TITLE',
              style: MyStyle.boldstyle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
