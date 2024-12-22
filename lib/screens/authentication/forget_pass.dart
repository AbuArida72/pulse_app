import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPasswordResetEmail(BuildContext context) async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      // Check if the email exists in the database
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Email exists, send password reset email
        await _auth.sendPasswordResetEmail(email: email);

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text(
                'A password reset link has been sent to $email. Please check your email to reset your password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pop(context); // Go back to the sign-in screen
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Email does not exist
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Email Not Found'),
            content: Text('The email you entered is not associated with any account.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: Dimensions.extraLargeTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: CustomColor.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimensions.heightSize * 4),
            Center(
              child: Text(
                "Reset Your Password",
                style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 2),
            Center(
              child: Text(
                "Enter your email to receive a password reset link.",
                style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address",
                    style: TextStyle(
                      fontSize: Dimensions.defaultTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radius),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter your email",
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 2),
                  ElevatedButton(
                    onPressed: () => sendPasswordResetEmail(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: CustomColor.primary,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      textStyle: TextStyle(
                        fontSize: Dimensions.largeTextSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Center(
                      child: Text('Send Reset Link'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
