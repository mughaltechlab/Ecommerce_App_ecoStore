// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/util/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/cartModel.dart';
import '../../models/product_models.dart';
import '../../widgets/header.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? id;
  const ProductDetailScreen({super.key, this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImg = 0;
  int count = 1;
  var newPrice = 0;

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return allProducts.isEmpty
        ? Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(5.h),
                child: Header(
                  title: "-----------",
                )),
            body: const Center(child: CircularProgressIndicator()))
        : Scaffold(
            appBar: PreferredSize(
                preferredSize: Size.fromHeight(5.h),
                child: Header(
                  title: allProducts.first.productName,
                )),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: FloatingActionButton.extended(
                  backgroundColor: Colors.deepPurpleAccent,
                  onPressed: () {
                    CartModel.addToCart(CartModel(
                      id: allProducts.first.id,
                      image: allProducts.first.imageUrls!.first,
                      name: allProducts.first.productName,
                      quantity: count,
                      price: newPrice,
                    )).whenComplete(() {
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: const Duration(milliseconds: 110),
                          backgroundColor: Colors.greenAccent.shade100,
                          content: const Text(
                            "Successfuly Added to Cart",
                            style: TextStyle(
                              fontSize: 19,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ));
                      });
                    });
                  },
                  label: const Text("ADD TO CART")),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 5.h),
              child: Column(
                children: [
                  // const SizedBox(height: 10),
                  // product Image
                  Image.network(
                    allProducts[0].imageUrls![selectedImg],
                    height: 35.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          allProducts[0].imageUrls!.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectedImg = index;
                                });
                              },
                              child: Image.network(
                                allProducts[0].imageUrls![index],
                                height: 10.h,
                                width: 10.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // add, sub button
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  // minus
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                      if (count > 3) {
                                        newPrice = count *
                                            allProducts.first.discountPrice!;
                                      } else {
                                        newPrice =
                                            count * allProducts.first.price!;
                                      }
                                    }
                                  });
                                },
                                icon: const Icon(Icons.exposure_minus_1),
                              ),
                              Container(
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$count",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.deepPurple,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                              IconButton(
                                onPressed: () {
                                  // plus
                                  setState(() {
                                    count++;
                                    if (count > 3) {
                                      newPrice = count *
                                          allProducts.first.discountPrice!;
                                    } else {
                                      newPrice =
                                          count * allProducts.first.price!;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.exposure_plus_1),
                              ),

                              //  favourite button
                              StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('favourite')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('items')
                                    .where('productId',
                                        isEqualTo: allProducts.first.id)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.data == null) {
                                    return const Text("");
                                  }
                                  return IconButton(
                                    onPressed: () {
                                      snapshot.data!.docs.isEmpty
                                          ? addToFav()
                                          : removeToFav(
                                              snapshot.data!.docs.first.id);
                                    },
                                    icon: Icon(
                                      snapshot.data!.docs.isEmpty
                                          ? Icons.favorite_outline
                                          : Icons.favorite,
                                      color: snapshot.data!.docs.isEmpty
                                          ? Colors.black
                                          : Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepOrange.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Text(
                                      newPrice.toString(),
                                      style: MyStyle.boldstyle.copyWith(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "\$",
                                      style: MyStyle.boldstyle.copyWith(
                                        fontSize: 20,
                                        color: Colors.teal.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // product Detail
                  Container(
                    constraints: BoxConstraints(
                      minWidth: double.infinity,
                      minHeight: 30.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 18),
                      child: Column(
                        children: [
                          Text(
                            allProducts.first.productDetail!.toUpperCase(),
                            textAlign: TextAlign.justify,
                            style: MyStyle.boldstyle.copyWith(
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 10),

                          //
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "NOTE: Discount of ${allProducts.first.discountPrice!.toString()} will\nbe applied on more than\nthree products if you selected",
                              textAlign: TextAlign.justify,
                              style: MyStyle.boldstyle.copyWith(
                                fontSize: 14,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  // ------------___F_U_N_C_T_I_O_N_S___-------------______________---LONEWOLF_SAQIB_AHMED________----------------
  List<ProductsModel> allProducts = [];

  Future getData() async {
    await FirebaseFirestore.instance
        .collection("products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element["id"] == widget.id)
          .forEach((e) {
        if (e.exists) {
          for (var element in e['imageUrls']) {
            if (element.isNotEmpty) {
              setState(() {
                allProducts.add(
                  ProductsModel(
                    category: e['category'],
                    id: e['id'],
                    brand: e['brand'],
                    productName: e['productName'],
                    productDetail: e['productDetail'],
                    serialCode: e['serialCode'],
                    imageUrls: e['imageUrls'],
                    price: e['price'],
                    discountPrice: e['discountPrice'],
                    isOnSale: e['isOnSale'],
                    isPopular: e['isPopular'],
                    isFavourite: e['isFavourite'],
                  ),
                );
              });
            }
          }
        }
        newPrice = allProducts.first.price!;
      });
    });
  }

  // Fovourite products
  addToFav() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');

    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .add({
      "productId": allProducts.first.id,
    });
  }

  removeToFav(String id) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('favourite');

    await collectionReference
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("items")
        .doc(id)
        .delete();
  }
}
