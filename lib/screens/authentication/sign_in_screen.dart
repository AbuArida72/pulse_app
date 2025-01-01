import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pulse/helpers/app_export.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/screens/authentication/forget_pass.dart';
import 'package:pulse/screens/dashboard.dart';
import 'package:pulse/screens/authentication/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _obscurePassword = true;

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      try {
        // Authenticate the user with email and password
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        User? user = userCredential.user;

        if (user != null) {
          // Fetch the user details from Firestore
          DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

          if (userDoc.exists) {
            final userData = userDoc.data() as Map<String, dynamic>;
            if (userData['status'] == 3) {
              // Navigate to the main dashboard if the status is 3
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashboardScreen()),
              );
            } else {
              // Show a message if the status is not 3
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Account Under Review'),
                  content: Text(
                      'Your account is still under review. Please wait, and you will receive an email once your account is approved.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            }
          } else {
            // User record not found in Firestore
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No user record found in the database.')),
            );
          }
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      appBar: AppBar(
        title: Text(
          Strings.signIn,
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
                "Welcome Back!",
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
                "Sign in to continue",
                style: TextStyle(
                  fontSize: Dimensions.defaultTextSize,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: Dimensions.heightSize * 4),
            bodyWidget(context),
          ],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: formKey,
          child: Padding(
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Strings.invalidInput;
                    }
                    return null;
                  },
                ),
                SizedBox(height: Dimensions.heightSize),
                Text(
                  "Password",
                  style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5),
                TextFormField(
                  controller: passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Dimensions.radius),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Strings.invalidInput;
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize),
          child: GestureDetector(
            child: Container(
              height: Dimensions.buttonHeight,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: CustomColor.primary,
                borderRadius: BorderRadius.circular(Dimensions.radius * 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  Strings.signIn.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            onTap: signIn,
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
            );
          },
          child: Text(
            'Forgot Password?',
            style: TextStyle(color: CustomColor.primary, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.noAccount,
              style: TextStyle(
                fontSize: Dimensions.defaultTextSize,
              ),
            ),
            GestureDetector(
              child: Text(
                Strings.createAccount.toUpperCase(),
                style: TextStyle(
                  color: CustomColor.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.defaultTextSize,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignUpScreen()),
                );
              },
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize * 2),
      ],
    );
  }
}
