import 'package:cloud_firestore/cloud_firestore.dart';

class ProductsModel {
  // variables
  String? category;
  String? id;
  String? brand;
  String? productName;
  String? productDetail;
  String? serialCode;
  List<dynamic>? imageUrls;
  int? price;
  int? discountPrice;
  bool? isOnSale;
  bool? isPopular;
  bool? isFavourite;

  // constructor

  ProductsModel({
    required this.category,
    this.id,
    required this.brand,
    required this.productName,
    required this.productDetail,
    required this.serialCode,
    required this.imageUrls,
    required this.price,
    required this.discountPrice,
    required this.isOnSale,
    required this.isPopular,
    required this.isFavourite,
  });

  // making functions for adding, updating and delete

  // collection reference
  static CollectionReference db =
      FirebaseFirestore.instance.collection("products");

  // add product
  static Future<void> addProduct(ProductsModel addPro) async {
    Map<String, dynamic> data = {
      "category": addPro.category,
      "productName": addPro.productName,
      "brand": addPro.brand,
      "productDetail": addPro.productDetail,
      "price": addPro.price,
      "discountPrice": addPro.discountPrice,
      "id": addPro.id,
      "imageUrls": addPro.imageUrls,
      "serialCode": addPro.serialCode,
      "isOnSale": addPro.isOnSale,
      "isPopular": addPro.isPopular,
      "isFavourite": addPro.isFavourite,
    };
    await db.add(data);
  }

  // update product
  static Future<void> updateProduct(String id, ProductsModel updatePro) async {
    Map<String, dynamic> data = {
      "category": updatePro.category,
      "brand": updatePro.brand,
      "productName": updatePro.productName,
      "productDetail": updatePro.productDetail,
      "price": updatePro.price,
      "discountPrice": updatePro.discountPrice,
      "id": updatePro.id,
      "imageUrls": updatePro.imageUrls,
      "serialCode": updatePro.serialCode,
      "isOnSale": updatePro.isOnSale,
      "isPopular": updatePro.isPopular,
      "isFavourite": updatePro.isFavourite,
    };
    await db.doc(id).update(data);
  }

  static Future<void> deleteProduct(String id) async {
    await db.doc(id).delete();
  }
}
