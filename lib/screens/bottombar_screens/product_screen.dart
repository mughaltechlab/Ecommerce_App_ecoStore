// ignore_for_file: avoid_function_literals_in_foreach_calls, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/screens/bottombar_screens/product_detail_screen.dart';
import 'package:eco_store/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../models/product_models.dart';
import '../../widgets/header.dart';

class ProductScreen extends StatefulWidget {
  String? categoryTitle;
  ProductScreen({super.key, this.categoryTitle});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchC = TextEditingController();

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.h),
          child: Header(
            title: widget.categoryTitle ?? "ALL PRODUCTS",
          )),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          children: [
            // search field
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: TextFormField(
                controller: searchC,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'search products...',
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: allProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  String pName = allProducts[index].productName!;
                  if (searchC.text.isEmpty) {
                    return SizedBox(
                      height: 15.h,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ProductDetailScreen(
                              id: allProducts[index].id,
                            );
                          }));
                        },
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              allProducts[index].imageUrls!.last,
                              // height: 100,
                              // width: 100,
                              fit: BoxFit.fill,
                            ),
                            title: Text(
                              allProducts[index].productName!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle:
                                Text(" ${allProducts[index].discountPrice} \$",
                                    style: MyStyle.boldstyle.copyWith(
                                      fontSize: 18,
                                    )),
                            trailing: Text(
                              "${allProducts[index].price} \$",
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else if (pName
                      .toString()
                      .toLowerCase()
                      .contains(searchC.text.toLowerCase())) {
                    return SizedBox(
                      height: 15.h,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return ProductDetailScreen(
                              id: allProducts[index].id,
                            );
                          }));
                        },
                        child: Card(
                          child: ListTile(
                            leading: Image.network(
                              allProducts[index].imageUrls!.last,
                              // height: 100,
                              // width: 100,
                              fit: BoxFit.fill,
                            ),
                            title: Text(
                              allProducts[index].productName!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle:
                                Text(" ${allProducts[index].discountPrice} \$",
                                    style: MyStyle.boldstyle.copyWith(
                                      fontSize: 18,
                                    )),
                            trailing: Text(
                              "${allProducts[index].price} \$",
                              style: const TextStyle(
                                  color: Colors.teal, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )

            // showing products
            // Expanded(
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2,
            //     ),
            //     itemCount: allProducts.length,
            //     itemBuilder: (BuildContext context, int index) {
            //       String pName = allProducts[index].productName!;

            //       if (searchC.text.isEmpty) {
            //         return Container(
            //           child: Column(
            //             children: [
            //               // product image
            //               Image.network(
            //                 allProducts[index].imageUrls!.last,
            //                 height: 100,
            //                 width: 100,
            //                 fit: BoxFit.cover,
            //               ),

            //               // product name
            //               Text(allProducts[index].productName!),
            //             ],
            //           ),
            //         );
            //       } else if (pName
            //           .toString()
            //           .toLowerCase()
            //           .contains(searchC.text.toLowerCase())) {
            //         return Container(
            //           child: Column(
            //             children: [
            //               // product image
            //               Image.network(
            //                 allProducts[index].imageUrls!.last,
            //                 height: 100,
            //                 width: 100,
            //                 fit: BoxFit.cover,
            //               ),

            //               // product name
            //               Text(allProducts[index].productName!),
            //             ],
            //           ),
            //         );
            //       } else {
            //         return Container();
            //       }
            //     },
            //   ),
            // ),
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
      if (widget.categoryTitle == null) {
        snapshot!.docs.forEach((e) {
          if (e.exists) {
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
        });
      } else {
        snapshot!.docs
            .where((element) => element['category'] == widget.categoryTitle)
            .forEach((e) {
          if (e.exists) {
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
        });
      }
    });
  }
}
