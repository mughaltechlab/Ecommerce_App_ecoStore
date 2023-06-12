import 'package:eco_store/screens/layout_screen.dart';
import 'package:eco_store/screens/web_side/admin_login.dart';
import 'package:eco_store/screens/web_side/admin_pannel.dart';
import 'package:eco_store/screens/web_side/web_screens/addproducts_screen.dart';
import 'package:eco_store/screens/web_side/web_screens/dashboard_screen.dart';
import 'package:eco_store/screens/web_side/web_screens/deleteproducts_screen.dart';
import 'package:eco_store/screens/web_side/web_screens/updateproducts_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDSy95zCVLq711Ar53u_--WNspriB6TLTo",
        authDomain: "eco-store-665e0.firebaseapp.com",
        projectId: "eco-store-665e0",
        storageBucket: "eco-store-665e0.appspot.com",
        messagingSenderId: "636770305401",
        appId: "1:636770305401:web:56cd8f9a4c7f0480931ba8",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Eco Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LayoutScreen(),
        routes: {
          AdminLogin.id: (context) => const AdminLogin(),
          AdminPannel.id: (context) => const AdminPannel(),
          DashboardScreen.id: (context) => const DashboardScreen(),
          AddProductScreen.id: (context) => const AddProductScreen(),
          UpdateProductScreen.id: (context) => const UpdateProductScreen(),
          DeleteProductScreen.id: (context) => const DeleteProductScreen(),
        },
      ),
    );
  }
}
