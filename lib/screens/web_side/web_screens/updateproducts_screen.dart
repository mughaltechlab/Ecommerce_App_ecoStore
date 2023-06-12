import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/models/product_models.dart';
import 'package:eco_store/screens/web_side/web_screens/update_complete_product.dart';
import 'package:eco_store/util/styles.dart';
import 'package:flutter/material.dart';

class UpdateProductScreen extends StatelessWidget {
  static const String id = "Update_product_screen";
  const UpdateProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Update PRODUCT",
                style: MyStyle.boldstyle,
              ),
            ),
          ),
          StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.amber.shade800,
                  ),
                );
              }
              if (snapshot.data == null) {
                return const Center(child: Text('There is no products'));
              }
              final myData = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        tileColor: Colors.black,
                        title: Text(
                          myData[index]['productName'],
                          style: MyStyle.boldstyle.copyWith(
                              fontSize: 16, color: Colors.blue.shade200),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return UpdateCompleteProduct(
                                id: myData[index].id,
                                productsModel: ProductsModel(
                                    category: myData[index]['category'],
                                    id: myData[index]['id'],
                                    brand: myData[index]['brand'],
                                    productName: myData[index]['productName'],
                                    productDetail: myData[index]
                                        ['productDetail'],
                                    serialCode: myData[index]['serialCode'],
                                    imageUrls: myData[index]['imageUrls'],
                                    price: myData[index]['price'],
                                    discountPrice: myData[index]
                                        ['discountPrice'],
                                    isOnSale: myData[index]['isOnSale'],
                                    isPopular: myData[index]['isPopular'],
                                    isFavourite: myData[index]['isFavourite']),
                              );
                            }));
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.amber.shade200,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
