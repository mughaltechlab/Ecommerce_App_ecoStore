// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/product_models.dart';
import '../screens/bottombar_screens/product_detail_screen.dart';
import '../util/styles.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    super.key,
    required this.allProducts,
  });

  final List<ProductsModel> allProducts;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            allProducts.where((element) => element.isPopular == true).map((e) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // popular product image

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 26.h,
                    width: 60.w,
                    child: Image.network(
                      e.imageUrls![1],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProductDetailScreen(
                                  id: e.id,
                                )));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 26.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple.shade200.withOpacity(.3),
                            Colors.purple.shade300.withOpacity(.3),
                            Colors.deepPurple.shade200.withOpacity(.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                //  product name
                Positioned(
                  bottom: 14,
                  // left: 10,
                  child: Container(
                    // width: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        e.brand!.toUpperCase(),
                        style: MyStyle.boldstyle.copyWith(
                          fontSize: 18,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withOpacity(.7),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
