// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/models/product_models.dart';
import 'package:eco_store/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/brands_name.dart';
import '../../widgets/categories_boxes.dart';
import '../../widgets/home_cards.dart';
import '../../widgets/homescreen_images_slider.dart';
import '../../widgets/popular_products.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // images for slider----------------------------------------
  List images = [
    "https://cdn.pixabay.com/photo/2017/05/13/12/40/fashion-2309519_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/08/01/11/48/woman-2564660__340.jpg",
    "https://cdn.pixabay.com/photo/2017/09/13/16/08/cosmetics-2746013_1280.jpg",
    "https://cdn.pixabay.com/photo/2017/08/15/12/58/mice-bacon-2643820_1280.jpg",
  ];

  // _____________________________________________________________
  // List<ProductsModel> allProducts = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5.h, bottom: 5.h),
        child: Column(
          children: [
            // MAIN TITLE----------------
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "🚅",
                style: MyStyle.boldstyle.copyWith(),
              ),
              TextSpan(
                  text: "ECO",
                  style: MyStyle.boldstyle.copyWith(
                      color: Colors.deepPurple,
                      fontFamily: 'serif',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0)),
              TextSpan(
                  text: "STORE",
                  style: MyStyle.boldstyle.copyWith(
                    fontSize: 30,
                    color: Colors.black,
                  )),
            ])),

            // ---------------------------

            // making caegories cards
            const CategoriesBoxes(),

            // ---------------------------

            // ------SLIDER---------------
            HomeImagesSlider(images: images),
            // -----------------slider_end------------------

            // top Brands
            const HomeCards(
              title: "TOP BRANDS",
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BrandName(brand: 'NIKE'),
                    BrandName(brand: 'SHIEKH SURMA'),
                    BrandName(brand: 'PUMA'),
                    BrandName(brand: 'DENIM'),
                    BrandName(brand: 'ADDIDAS'),
                    BrandName(brand: 'DELL'),
                  ],
                ),
              ),
            ),

            // -----------popular products-----------------
            const HomeCards(
              title: "POPULAR PRODUCTS",
            ),
            allProducts.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PopularProducts(allProducts: allProducts),

            // hot sales
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
      for (var e in snapshot!.docs) {
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
      }
    });
  }
}
