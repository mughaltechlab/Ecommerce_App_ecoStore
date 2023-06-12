// ignore_for_file: sized_box_for_whitespace

import 'package:eco_store/screens/bottombar_screens/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../models/category_model.dart';
import '../util/styles.dart';

class CategoriesBoxes extends StatelessWidget {
  const CategoriesBoxes({
    super.key,
    // required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            categories.length,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 7.h,
                // width: ,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(
                              categoryTitle: categories[index].title),
                        ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      // color: Colors.primaries[Random().nextInt(categories.length)]
                      //     .shade200,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.pink.withOpacity(.4),
                          blurRadius: 5,
                          spreadRadius: 3,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                      // shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          // icon
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.shade200,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ], shape: BoxShape.circle, color: Colors.black),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(categories[index].icon!),
                            ),
                          ),

                          const SizedBox(width: 5),

                          // title
                          Center(
                              child: Text(
                            categories[index].title!,
                            textAlign: TextAlign.center,
                            style: MyStyle.boldstyle.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          )),
                          const SizedBox(width: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
