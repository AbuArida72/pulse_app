import 'package:pulse/helpers/app_export.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/screens/authentication/sign_in_screen.dart';
import 'package:pulse/screens/welcome_screen.dart';

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
  TextEditingController cityController = TextEditingController();
  TextEditingController StreetController = TextEditingController();

  bool _toggleVisibility = true;
  bool checkedValue = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      appBar: AppBar(title: Text(Strings.createAccount),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bodyWidget(context)
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
              padding: const EdgeInsets.only(
                  top: Dimensions.heightSize * 2,
                  left: Dimensions.marginSize,
                  right: Dimensions.marginSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInput(
                    controller: usernameController,
                    hintText: Strings.type,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || (!isText(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  CustomInput(
                    controller: emailController,
                    hintText: Strings.type,
                    textInputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          (!isValidEmail(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  CustomInput(
                    controller: passwordController,
                    hintText: Strings.type,
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null ||
                          (!isValidPassword(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  CustomInput(
                    controller: mobileController,
                    hintText: Strings.type,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || (!isText(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  CustomInput(
                    controller: StreetController,
                    hintText: Strings.type,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || (!isText(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  CustomInput(
                    controller: cityController,
                    hintText: Strings.type,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || (!isText(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: Dimensions.heightSize,
                  ),
                  CustomInput(
                    controller: cityController,
                    hintText: Strings.type,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || (!isText(value, isRequired: true))) {
                        return Strings.invalidInput;
                      }
                      return null;
                    },
                  ),
                ],
              ),
            )),
        SizedBox(height: Dimensions.heightSize * 2),
        Padding(
          padding: const EdgeInsets.only(
              left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primary,
                  borderRadius:
                      BorderRadius.all(Radius.circular(Dimensions.radius * 3))),
              child: Center(
                child: Text(
                  Strings.createAnAccount.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () async {
              setState(() {
                isLoading = true;
              });
              if (formKey.currentState!.validate()) {
                await AuthService()
                    .register(
                        email: emailController.text,
                        password: passwordController.text)
                    .then((value) async {
                  if (value!.contains('Success')) {
                    Map<String, dynamic> userDetails = {
                      'email': emailController.text,
                      // 'image': imageUrl,
                      'mobile': mobileController.text,
                      'username': usernameController.text,
                      'notification': false,
                      'payments': [],
                      'privilege': 1,
                      // Add other user data as needed
                    };

                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .set(userDetails);
                      if (FirebaseAuth.instance.currentUser!.emailVerified) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => IntroScreen(),
                          ),
                          (route) => false,
                        );
                      } else {
                        showMsg(
                          context,
                          'Account Verification\nYou should verify your account.',
                          oncancel: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pop(context);
                          },
                          onpress: () async {
                            await FirebaseAuth.instance.currentUser!
                                .sendEmailVerification()
                                .then(
                                  (value) => FirebaseAuth.instance.signOut(),
                                );

                            Navigator.pop(context);
                          },
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(e.toString())),
                      );
                    }
                  }
                }).catchError(
                  (onError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(onError.toString())),
                    );
                  },
                );
              }
              setState(() {
                isLoading = false;
              });
            },
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "By creating an account you agree to the following ",
              style: CustomStyle.textStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Text(
                    "Terms and Conditions",
                    style: TextStyle(
                        fontSize: Dimensions.defaultTextSize,
                        fontWeight: FontWeight.bold,
                        color: CustomColor.blue,
                        decoration: TextDecoration.underline),
                  ),
                  onTap: () {
                    print('go to privacy url');
                    //_showTermsConditions();
                  },
                ),
                Text(
                  " without reservation",
                  style: CustomStyle.textStyle,
                ),
              ],
            )
          ],
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.alreadyHaveAnAccount,
              style: CustomStyle.textStyle,
            ),
            GestureDetector(
              child: Text(
                Strings.signIn.toUpperCase(),
                style: TextStyle(
                    color: CustomColor.primary, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  SignInScreen()));
              },
            )
          ],
        )
      ],
    );
  }
}
