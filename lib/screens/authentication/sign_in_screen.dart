import 'package:pulse/helpers/app_export.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/screens/main_dashboard.dart';
import 'package:pulse/screens/authentication/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

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

  bodyWidget(BuildContext context) {
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
            onTap: () async {
              /*
              Firebase authentication code remains unchanged
              */
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(),
                ),
                (route) => false,
              );
            },
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
