import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  // function for LOGIN ADMIN
  static Future<DocumentSnapshot> adminLogin(id) async {
    var result =
        await FirebaseFirestore.instance.collection('admin').doc(id).get();
    return result;
  }

  // function for creating account
  static Future<String?> createAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return 'email already in use';
      } else if (e.code == "invalid-password") {
        return 'invalid password contains at least 6 char';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // function for login
  static Future<String?> logInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // function for logOut
  static Future<void> logOutAccount() async {
    await FirebaseAuth.instance.signOut();
  }
}
