// ignore_for_file: avoid_unnecessary_containers

import 'dart:io';

import 'package:eco_store/models/product_models.dart';
import 'package:eco_store/util/styles.dart';
import 'package:eco_store/widgets/my_textfield.dart';
import 'package:eco_store/widgets/mybtn.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';

import '../../../models/category_model.dart';

class AddProductScreen extends StatefulWidget {
  static const String id = "add_product_screen";
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
// ____VARIABLES_________------------____________
  // List items = categories;

  String? selectedValue;

  final imagePicker = ImagePicker(); //making an object of ImagePicker.

  List<XFile> images = [];

  List<String> imageUrls = [];

  bool isSaving = false;

// ____END---VARIABLES_________------------____________
// for---Generating---Unique---ID-----
  var uuid = const Uuid();
// -----------_________________------------
// ----------CONTROLLERS----------------------------

  TextEditingController categoryC = TextEditingController();
  TextEditingController idC = TextEditingController();
  TextEditingController productNameC = TextEditingController();
  TextEditingController productDetailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountPriceC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  // TextEditingController isOnSaleC = TextEditingController();
  // TextEditingController isPopularC = TextEditingController();
  // TextEditingController isFavouriteC = TextEditingController();
  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;

// --------END--CONTROLLERS----------------------------

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              const Center(
                child: Text(
                  "ADD PRODUCT",
                  style: MyStyle.boldstyle,
                ),
              ),

              // dropdown list of categories
              DropdownButtonFormField(
                focusColor: Colors.deepPurple.shade100,
                dropdownColor: Colors.deepPurple.shade100,
                alignment: Alignment.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
                value: selectedValue,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "category must be selected";
                  } else {
                    return null;
                  }
                },
                items: categories
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e.title,
                        child: Text(
                          e.title!,
                          style: MyStyle.boldstyle.copyWith(
                            fontSize: 20,
                            color: Colors.purple,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),

              // product form-----------________---------
              MyTextField(
                controller: productNameC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "fill these required blanks";
                  } else {
                    return null;
                  }
                },
                hintText: 'Enter Product Name',
              ),
              MyTextField(
                controller: brandC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "fill these required blanks";
                  } else {
                    return null;
                  }
                },
                hintText: 'Enter Product Brand',
              ),
              MyTextField(
                controller: productDetailC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "fill these required blanks";
                  } else {
                    return null;
                  }
                },
                hintText: 'Enter Product Detail',
                maxLines: 5,
              ),
              MyTextField(
                controller: priceC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "fill these required blanks";
                  } else {
                    return null;
                  }
                },
                hintText: 'Enter Product Price',
              ),
              MyTextField(
                controller: discountPriceC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "fill these required blanks";
                  } else {
                    return null;
                  }
                },
                hintText: 'Enter Product Discount Price',
              ),
              MyTextField(
                controller: serialCodeC,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "fill these required blanks";
                  } else {
                    return null;
                  }
                },
                hintText: 'Enter Product Serial Code',
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is Product On Sale?",
                        style: MyStyle.boldstyle.copyWith(fontSize: 18),
                      ),
                      CupertinoSwitch(
                        value: isOnSale,
                        onChanged: (v) {
                          setState(() {
                            isOnSale = !isOnSale;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Is Product Popular?",
                        style: MyStyle.boldstyle.copyWith(fontSize: 18),
                      ),
                      CupertinoSwitch(
                        value: isPopular,
                        onChanged: (v) {
                          setState(() {
                            isPopular = !isPopular;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // ____----BUTTON-----_______
              MyButton(
                btnName: "PICK IMAGE",
                btnColor: Colors.black,
                btnNameColor: Colors.amber,
                btnFunc: pickImage,
              ),
              // MyButton(
              //   btnName: "UPLOAD IMAGE",
              //   btnColor: Colors.black,
              //   btnNameColor: Colors.amber,
              //   btnFunc: uploadImage,
              // ),
              // MyButton(
              //   btnName: "SAVE",
              //   btnColor: Colors.black,
              //   btnNameColor: Colors.amber,
              //   isLoading: isSaving,
              //   btnFunc: save,
              // ),
              // ------xxxx------___xxxxx______-----xxxxx---------___xxxxx_____

              // container for seeing picking images....................
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(.3),
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          // seeing picking images
                          Container(
                            height: 250,
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.deepPurple.shade200,
                            ),
                            child: Image.network(
                              File(images[index].path).path,
                              fit: BoxFit.contain,
                            ),
                          ),

                          // making remove button
                          Positioned(
                            right: 10,
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                              icon: Container(
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              //  saving button
              MyButton(
                btnName: "SAVE",
                btnColor: Colors.black,
                btnNameColor: Colors.amber,
                isLoading: isSaving,
                btnFunc: save,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------______________----FUNCTIONS---------_____________-------------

  // for picking multiple images from device
  pickImage() async {
    final List<XFile> pickImages = await imagePicker.pickMultiImage();
    if (pickImages.isNotEmpty) {
      setState(() {
        images.addAll(pickImages);
      });
    } else {
      // ignore: avoid_print
      print("images not selected");
    }
  }

  // for uploading images as bytes
  Future postimages(XFile? imageFile) async {
    String? urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.name);

    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(
          contentType: "image/jpeg",
        ),
      );
      urls = await ref.getDownloadURL();
      return urls;
    }
  }

  // loop function for uploading all images and getting all urls
  uploadImage() async {
    for (var image in images) {
      await postimages(image).then(
        (downloadUrl) => imageUrls.add(downloadUrl),
      );
    }
  }

  // saving all urls & upload product data into cloud firestore,&
  //  upload images into firebase storage.
  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImage();
    await ProductsModel.addProduct(ProductsModel(
      category: selectedValue,
      id: uuid.v4(),
      brand: brandC.text,
      productName: productNameC.text,
      productDetail: productDetailC.text,
      serialCode: serialCodeC.text,
      imageUrls: imageUrls,
      price: int.parse((priceC.text)),
      discountPrice: int.parse((discountPriceC.text)),
      isOnSale: isOnSale,
      isPopular: isPopular,
      isFavourite: isFavourite,
    )).whenComplete(
      () {
        setState(() {
          isSaving = false;
          images.clear();
          imageUrls.clear();
          clearfields();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green.shade200,
              content: const Row(
                children: [
                  Icon(
                    Icons.done_all,
                    color: Color.fromARGB(255, 8, 96, 13),
                  ),
                  Text("Saved Successfully"),
                ],
              )));
        });
      },
    );
    // await FirebaseFirestore.instance.collection("products").add(
    //   {"images": imageUrls},
    // ).whenComplete(
    //   () {
    //     setState(() {
    //       isSaving = false;
    //       images.clear();
    //     });
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //         backgroundColor: Colors.green.shade200,
    //         content: Row(
    //           children: const [
    //             Icon(
    //               Icons.done_all,
    //               color: Color.fromARGB(255, 8, 96, 13),
    //             ),
    //             Text("Saved Successfully"),
    //           ],
    //         )));
    // },
    // );
  }

  clearfields() {
    setState(() {
      // selectedValue ='';
      productNameC.clear();
      productDetailC.clear();
      priceC.clear();
      discountPriceC.clear();
      serialCodeC.clear();
    });
  }
}
