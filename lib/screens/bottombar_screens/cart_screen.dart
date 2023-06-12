// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/header.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

// function for removing selected cart item
  remove(String? id, BuildContext context) async {
    final CollectionReference db =
        FirebaseFirestore.instance.collection('cart');

    db.doc(id).delete().then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Delete successfuly'),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: Header(
          title: "CART",
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('cart').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text("Cart Empty"),
            );
          }
          return Container(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final data = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.deepPurple[50],
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: ListTile(
                        isThreeLine: true,
                        leading: Image.network(
                          data['image'],
                          // height: 100,
                          // width: 100,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          data['productName'].toString().toUpperCase(),
                          style: MyStyle.boldstyle.copyWith(
                            color: Colors.deepPurpleAccent,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Qty: ${data['quantity']} ",
                                style: MyStyle.boldstyle.copyWith(
                                  fontSize: 18,
                                )),
                            const SizedBox(height: 10),
                            Text("💲${data['price']}  ",
                                style: MyStyle.boldstyle.copyWith(
                                  fontSize: 18,
                                  color: Colors.teal.shade600,
                                )),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            remove(data.id, context);
                          },
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
