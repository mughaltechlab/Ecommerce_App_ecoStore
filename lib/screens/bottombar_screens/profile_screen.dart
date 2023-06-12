// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eco_store/widgets/header.dart';
import 'package:eco_store/widgets/my_textfield.dart';
import 'package:eco_store/widgets/mybtn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // text editting controller
  TextEditingController nameC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController houseC = TextEditingController();
  TextEditingController streetC = TextEditingController();
  TextEditingController cityC = TextEditingController();
  TextEditingController addressC = TextEditingController();

  // ---------
  final formKey = GlobalKey<FormState>(); //form key

  String? profilePic; //for storing profile pic path

  bool isloading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.deepPurple.shade300,
            content: const Text(
              'Fill your Profile',
              style: TextStyle(color: Colors.white),
            )));
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
          nameC.text = snapshot['userName'];
          phoneC.text = snapshot['phone'];
          houseC.text = snapshot['house'];
          streetC.text = snapshot['street'];
          cityC.text = snapshot['city'];
          addressC.text = snapshot['address'];

          setState(() {
            profilePic = snapshot['profilePic'];
          });
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(5.h),
        child: Header(title: 'PROFILE'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final XFile? pickImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery, imageQuality: 50);
                      if (pickImage != null) {
                        setState(() {
                          profilePic = pickImage.path;
                        });
                      }
                    },
                    child: Container(
                      child: profilePic == null
                          ? CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.grey.shade600,
                              child: Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.deepOrange.shade50,
                              ),

                              // backgroundImage: const AssetImage(
                              //   'assets/images/user.png',

                              // ),
                            )
                          : profilePic!.contains('http')
                              ? CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(profilePic!),
                                )
                              : CircleAvatar(
                                  radius: 70,
                                  backgroundImage: FileImage(File(profilePic!)),
                                ),
                    ),
                  ),

                  // Textfields
                  MyTextField(
                    controller: nameC,
                    hintText: 'user name',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: phoneC,
                    hintText: 'phone no:',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: houseC,
                    hintText: 'house no:',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: streetC,
                    hintText: 'street',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: cityC,
                    hintText: 'city name',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  MyTextField(
                    controller: addressC,
                    hintText: 'user complete address',
                    validate: (v) {
                      if (v!.isEmpty) {
                        return 'should not be empty';
                      }
                      return null;
                    },
                  ),
                  MyButton(
                    isLoading: isloading,
                    btnFunc: () {
                      if (formKey.currentState!.validate()) {
                        SystemChannels.textInput.invokeMapMethod(
                            'TextInput.hide'); //for hiding keyboard

                        profilePic == null
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                backgroundColor: Colors.pink,
                                content: Text(
                                  'select profile image',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                            : saveUser();
                      }
                    },
                    btnName: nameC.text.isEmpty ? 'SAVE' : 'UPDATE',
                    btnColor: Colors.teal,
                    btnNameColor: Colors.black,
                  ),
                  MyButton(
                    btnFunc: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    btnName: 'SIGN OUT',
                    btnColor: Colors.red.shade400,
                    btnNameColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // -------______________----FUNCTIONS-------<LONEWOLF--___SAQIB__AHMED__>________-------------

// here we creating a String variable for storing profile image Url
  String? profileUrl;
// for uploading profile image and getting url...
  Future<String?> uploadImage(File filePath, String? reference) async {
    try {
      // here we created filename
      final fileName =
          '${FirebaseAuth.instance.currentUser!.uid}${DateTime.now().second}';
      // here we create a reference of firebase storage
      final Reference fbStorage =
          FirebaseStorage.instance.ref(reference).child(fileName);

      // well it is its class define in fbase storage
      final UploadTask uploadTask = fbStorage.putFile(filePath);

      await uploadTask.whenComplete(() async {
        profileUrl = await fbStorage.getDownloadURL();
      });

      return profileUrl!;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  // ________________________uploadImage_______func_end_________________//

  saveUser() {
    setState(() {
      isloading = true;
    });
    uploadImage(File(profilePic!), 'profile').whenComplete(() {
      Map<String, dynamic> data = {
        'userName': nameC.text,
        'phone': phoneC.text,
        'house': houseC.text,
        'street': streetC.text,
        'city': cityC.text,
        'address': addressC.text,
        'profilePic': profileUrl,
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(data)
          .whenComplete(() {
        FirebaseAuth.instance.currentUser!.updateDisplayName(nameC.text);
        setState(() {
          isloading = false;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: nameC.text.isEmpty
                  ? const Text('SAVE INFO SUCCESSFULY')
                  : const Text('UPDATE INFO SUCCESSFULY'),
            ),
          );
        });
      });
    });
  }
}
