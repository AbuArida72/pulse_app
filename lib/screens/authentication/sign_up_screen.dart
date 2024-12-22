import 'package:flutter/material.dart';
import 'package:pulse/helpers/app_export.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/screens/authentication/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  String? selectedCity;
  String? documentPath;
  bool _obscurePassword = true;

  Future<void> pickDocument() async {
    // Code for picking a document goes here
    setState(() {
      documentPath = "path/to/selected/document";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      appBar: AppBar(
        title: Text(
          Strings.createAccount,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: CustomColor.primary,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.heightSize * 2),
              Text(
                "Welcome to PULSE",
                style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.primary,
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 2),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildInputField("Name", usernameController, TextInputType.text),
                    buildInputField("Email", emailController, TextInputType.emailAddress),
                    buildPasswordField("Password", passwordController),
                    buildInputField("Mobile Number", mobileController, TextInputType.phone),
                    buildInputField("Street", streetController, TextInputType.text),
                    buildCityDropdown(),
                    SizedBox(height: Dimensions.heightSize),
                    Text(
                      "Registration Document",
                      style: TextStyle(fontSize: Dimensions.defaultTextSize, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5),
                    GestureDetector(
                      onTap: pickDocument,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(Dimensions.radius),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            documentPath != null ? "Document Selected" : "Upload Document",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 2),
                    GestureDetector(
                      child: Container(
                        height: 50.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: CustomColor.primary,
                          borderRadius: BorderRadius.circular(Dimensions.radius * 3),
                        ),
                        child: Center(
                          child: Text(
                            Strings.createAnAccount.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.largeTextSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // Firebase registration logic remains unchanged
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 2),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.alreadyHaveAnAccount,
                      style: TextStyle(fontSize: Dimensions.defaultTextSize),
                    ),
                    GestureDetector(
                      child: Text(
                        Strings.signIn.toUpperCase(),
                        style: TextStyle(
                          color: CustomColor.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimensions.defaultTextSize,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => SignInScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.heightSize * 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller, TextInputType inputType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.defaultTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 0.5),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Enter your $label",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter your $label";
            }
            return null;
          },
        ),
        SizedBox(height: Dimensions.heightSize),
      ],
    );
  }

  Widget buildPasswordField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: Dimensions.defaultTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 0.5),
        TextFormField(
          controller: controller,
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
              return "Please enter your password";
            }
            return null;
          },
        ),
        SizedBox(height: Dimensions.heightSize),
      ],
    );
  }

  Widget buildCityDropdown() {
    final cities = ['Amman', 'Zarqa', 'Irbid', 'Madaba', 'Aqaba'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "City",
          style: TextStyle(
            fontSize: Dimensions.defaultTextSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 0.5),
        DropdownButtonFormField<String>(
          value: selectedCity,
          items: cities.map((city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: "Select your city",
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please select your city";
            }
            return null;
          },
        ),
        SizedBox(height: Dimensions.heightSize),
      ],
    );
  }
}
