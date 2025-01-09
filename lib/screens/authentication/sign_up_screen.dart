import 'package:file_picker/file_picker.dart';
import 'package:pulse/helpers/app_export.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/screens/authentication/sign_in_screen.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';


class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  String? selectedCity;
  String? documentPath;
  bool _obscurePassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Pick a PDF document
  /// Pick a PDF document and upload it to Firebase Storage
Future<void> pickDocument() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'], // Only allow PDFs
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final fileName = result.files.single.name;

      // Reference to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('commercial_registers')
          .child(fileName);

      // Upload the file
      final uploadTask = storageRef.putFile(file);

      // Wait for the upload to complete and get the download URL
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        documentPath = downloadUrl; // Store the Firebase URL
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Document uploaded: $fileName')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No document selected')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to upload document: $e')),
    );
  }
}


  Future<void> registerUser() async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await userCredential.user!.sendEmailVerification();

        Timestamp currentTimestamp = Timestamp.now();

        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'cardCVV': '',
          'cardEx': '',
          'cardNum': '',
          'city': selectedCity,
          'commercial_register': documentPath ?? '',
          'createdDtm': currentTimestamp,
          'email': emailController.text.trim(),
          'lastLoginTime': currentTimestamp,
          'phone': mobileController.text.trim(),
          'picture': 'https://firebasestorage.googleapis.com/v0/b/pulse-provider-app.appspot.com/o/default-avatar.png',
          'status': 0,
          'street': streetController.text.trim(),
          'username': usernameController.text.trim(),
        });

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Verify Your Email'),
            content: Text(
              'A verification email has been sent to your email address. Please check your inbox and verify your account.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
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
                            documentPath != null ? "Selected: ${documentPath!.split('/').last}" : "Upload Document",
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
                      onTap: registerUser,
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
            // Additional validation for phone number
            if (label == "Mobile Number") {
              if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return "Mobile number must be exactly 10 digits.";
              }
            }
            // Additional validation for email
            if (label == "Email") {
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return "Please enter a valid email address.";
              }
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
            if (value.length < 8) {
              return "Password must be at least 8 characters.";
            }
            if (!RegExp(r'[0-9]').hasMatch(value)) {
              return "Password must include at least one number.";
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
