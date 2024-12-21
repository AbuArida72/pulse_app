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
  bool _toggleVisibility = true;
  bool checkedValue = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      appBar: AppBar(title: Text(Strings.signIn),),
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
                    controller: emailController,
                    hintText: Strings.type,
                    textInputType: TextInputType.emailAddress,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Strings.invalidInput;
                      } else {
                        return null;
                      }
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
                      if (value!.isEmpty) {
                        return Strings.invalidInput;
                      } else {
                        return null;
                      }
                    },
                  )
                ],
              ),
            )
          ),
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
                  Strings.signIn.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            onTap: () async {/*
              if (formKey.currentState!.validate()) {
                setState(() {
                  isLoading = true;
                });

                await AuthService()
                    .login(
                  email: emailController.text,
                  password: passwordController.text,
                )
                    .then((res) {
                  if (res!.contains('Success')) {
                    if (FirebaseAuth.instance.currentUser!.emailVerified) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardScreen(),
                        ),
                        (route) => false,
                      );
                    } else {
                      showMsg(
                        context,
                        'Account Verification\nPlease Verify Your Email',
                        showCancle: true,
                        oncancel: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.of(context).pop();
                        },
                        onpress: () async {
                          await FirebaseAuth.instance.currentUser!
                              .sendEmailVerification()
                              .then(
                                (value) => FirebaseAuth.instance.signOut(),
                              );
                          Navigator.of(context).pop();
                        },
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(res)),
                    );
                  }
                  setState(() {
                    isLoading = false;
                  });
                });
              }*/
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
              style: CustomStyle.textStyle,
            ),
            GestureDetector(
              child: Text(
                Strings.createAccount.toUpperCase(),
                style: TextStyle(
                    color: CustomColor.primary, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
            )
          ],
        )
      ],
    );
  }
}
