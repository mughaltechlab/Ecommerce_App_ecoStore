import 'package:eco_store/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: Header(title: 'Checkout'),
      ),
    );
  }
}
