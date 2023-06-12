// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartModel {
  String? id, name, image;
  int? price, quantity;

  CartModel({
    @required this.id,
    @required this.image,
    @required this.name,
    @required this.quantity,
    @required this.price,
  });

  static Future<void> addToCart(CartModel cart) async {
    CollectionReference db = FirebaseFirestore.instance.collection('cart');
    Map<String, dynamic> data = {
      "id": cart.id,
      "productName": cart.name,
      "image": cart.image,
      "price": cart.price,
      "quantity": cart.quantity,
    };
    await db.add(data);
  }
}
