import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  String? userId = FirebaseAuth.instance.currentUser?.uid;
  Future<String?> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String user_id) async {
    try {
      Map<String, dynamic>? userDetails; // Variable to store user details

      // Fetch user document
      var userDocSnapshot = await usersCollection.doc(user_id).get();

      if (userDocSnapshot.exists) {
        // If the document exists, store its data in userDetails
        userDetails = userDocSnapshot.data() as Map<String, dynamic>?;
        return userDetails;
      }
    } catch (e) {
      // Handle any errors
    }

    return null; // Return null if user details couldn't be fetched
  }
}