import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../util/styles.dart';

class BrandName extends StatelessWidget {
  final String? brand;
  const BrandName({
    super.key,
    required this.brand,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        height: 10.h,
        width: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.red.shade900,
                Colors.black,
              ]),
        ),
        child: Center(
          child: Text(
            brand!,
            textAlign: TextAlign.center,
            style: MyStyle.boldstyle.copyWith(
              color: Colors.white,
              letterSpacing: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
