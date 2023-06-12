import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/screens/bottombar_screens/cart_screen.dart';
import 'package:eco_store/screens/bottombar_screens/checkout_screen.dart';
import 'package:eco_store/screens/bottombar_screens/favourite_screen.dart';
import 'package:eco_store/screens/bottombar_screens/home_screen.dart';
import 'package:eco_store/screens/bottombar_screens/product_screen.dart';
import 'package:eco_store/screens/bottombar_screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int length = 0;

  void cartItemsLength() {
    FirebaseFirestore.instance.collection('cart').get().then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          length = value.docs.length;
        });
      } else {
        setState(() {
          length = 0;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartItemsLength();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
              activeColor: Colors.deepPurple.shade400,
              inactiveColor: Colors.deepPurple.shade200,
              iconSize: 35,
              items: [
                const BottomNavigationBarItem(icon: Icon(Icons.home)),
                const BottomNavigationBarItem(icon: Icon(Icons.shop_2_sharp)),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_outlined)),
                BottomNavigationBarItem(
                    icon: Stack(
                  children: [
                    // CART ICON
                    const Icon(Icons.shopping_cart),

                    // CART BADGE showing items number
                    Positioned(
                      top: 1,
                      left: 1,
                      child: length == 0
                          ? Container()
                          : Stack(
                              children: [
                                Container(
                                  height: 18.sp,
                                  width: 18.sp,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.greenAccent.withOpacity(.6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '$length',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.deepPurpleAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                )),
                const BottomNavigationBarItem(
                    icon: Icon(Icons.price_check_outlined)),
                const BottomNavigationBarItem(icon: Icon(Icons.person)),
              ]),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: ((context) =>
                      const CupertinoPageScaffold(child: HomeScreen())),
                );
              // return const HomeScreen();
              case 1:
                return CupertinoTabView(
                  builder: ((context) =>
                      CupertinoPageScaffold(child: ProductScreen())),
                );
              // return ProductScreen();

              case 2:
                return CupertinoTabView(
                  builder: ((context) =>
                      const CupertinoPageScaffold(child: FavouriteScreen())),
                );
              // return const FavouriteScreen();

              case 3:
                return CupertinoTabView(
                  builder: ((context) =>
                      const CupertinoPageScaffold(child: CartScreen())),
                );
              // return const CartScreen();
              case 4:
                if (FirebaseAuth.instance.currentUser!.displayName == null) {
                  return CupertinoTabView(
                    builder: ((context) =>
                        const CupertinoPageScaffold(child: ProfileScreen())),
                  );
                }
                return CupertinoTabView(
                  builder: ((context) =>
                      const CupertinoPageScaffold(child: CheckoutScreen())),
                );

              case 5:
                return CupertinoTabView(
                  builder: ((context) =>
                      const CupertinoPageScaffold(child: ProfileScreen())),
                );
              // return const ProfileScreen();

              default:
                return const BottomNavBarScreen();
            }
          }),
    );
  }
}
