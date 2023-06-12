// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/screens/bottombar_screens/product_detail_screen.dart';
import 'package:eco_store/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/header.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    getFavProductId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: Header(
          title: "FAVORITE",
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return Center(
              child: Text(
                "Favorite Products are showing here",
                style: MyStyle.boldstyle.copyWith(fontSize: 18),
              ),
            );
          }

          List<QueryDocumentSnapshot<Object?>> fp = snapshot.data!.docs
              .where((element) => ids.contains(element['id']))
              .toList();

          return ListView.builder(
            itemCount: fp.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                                  id: fp[index]['id'],
                                )));
                  },
                  child: Card(
                    color: Colors.primaries[Random().nextInt(15)].shade200,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          fp[index]["productName"],
                          style: MyStyle.boldstyle.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        trailing: const Icon(Icons.navigate_next_rounded),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ------------___F_U_N_C_T_I_O_N_S___-------------______________---LONEWOLF_SAQIB_AHMED________----------------
  List ids = [];

  getFavProductId() async {
    FirebaseFirestore.instance
        .collection('favourite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('items')
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> snapshot) {
      snapshot.docs.forEach((element) {
        setState(() {
          ids.add(element['productId']);
        });
      });
    });
  }
}
