import 'package:eco_store/screens/web_side/web_screens/addproducts_screen.dart';
import 'package:eco_store/screens/web_side/web_screens/dashboard_screen.dart';
import 'package:eco_store/screens/web_side/web_screens/deleteproducts_screen.dart';
import 'package:eco_store/screens/web_side/web_screens/updateproducts_screen.dart';
import 'package:eco_store/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class AdminPannel extends StatefulWidget {
  static const String id = "adminpannel";
  const AdminPannel({super.key});

  @override
  State<AdminPannel> createState() => _AdminPannelState();
}

class _AdminPannelState extends State<AdminPannel> {
  Widget selectedScreen = const DashboardScreen();

  chooseScreen(item) {
    switch (item) {
      case DashboardScreen.id:
        setState(() {
          selectedScreen = const DashboardScreen();
        });
        break;
      case AddProductScreen.id:
        setState(() {
          selectedScreen = const AddProductScreen();
        });
        break;
      case UpdateProductScreen.id:
        setState(() {
          selectedScreen = const UpdateProductScreen();
        });

        break;
      case DeleteProductScreen.id:
        setState(() {
          selectedScreen = const DeleteProductScreen();
        });

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'ADMIN PANNEL',
          style: MyStyle.boldstyle.copyWith(
            color: Colors.amber.shade200,
          ),
        ),
      ),
      sideBar: SideBar(
        backgroundColor: Colors.black.withOpacity(.4),
        iconColor: Colors.amber.shade200,
        textStyle: MyStyle.boldstyle.copyWith(
          color: Colors.deepPurple.shade100,
          fontSize: 16,
        ),
        onSelected: (item) {
          chooseScreen(item.route);
        },
        items: const [
          AdminMenuItem(
            title: "DASHBOARD",
            icon: Icons.dashboard_sharp,
            route: DashboardScreen.id,
          ),
          AdminMenuItem(
            title: "ADD PRODUCTS",
            icon: Icons.add_to_photos,
            route: AddProductScreen.id,
          ),
          AdminMenuItem(
            title: "UPDATE PRODUCTS",
            icon: Icons.update,
            route: UpdateProductScreen.id,
          ),
          AdminMenuItem(
            title: "DELETE PRODUCTS",
            icon: Icons.delete,
            route: DeleteProductScreen.id,
          ),
          AdminMenuItem(
            title: "CART",
            icon: Icons.shopping_cart_rounded,
          ),
        ],
        selectedRoute: AdminPannel.id,
      ),
      body: selectedScreen,
    );
  }
}
