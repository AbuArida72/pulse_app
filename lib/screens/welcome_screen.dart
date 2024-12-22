import 'package:flutter/material.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/screens/authentication/sign_up_screen.dart';
import 'package:pulse/screens/authentication/sign_in_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [CustomColor.primary.withOpacity(0.8), CustomColor.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: Dimensions.heightSize * 7),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 2),
                    child: Text(
                      Strings.title,
                      style: TextStyle(
                        fontSize: Dimensions.extraLargeTextSize * 3,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 2),
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
                            Strings.createAnAccount.toUpperCase(),
                            style: TextStyle(
                              fontSize: Dimensions.largeTextSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen()));
                      },
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize * 2),
                    child: GestureDetector(
                      child: Container(
                        height: Dimensions.buttonHeight,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: CustomColor.secondary.withOpacity(0.8),
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
                              fontSize: Dimensions.largeTextSize,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen()));
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: -50,
                right: -10,
                left: -10,
                child: Image.asset(
                  'assets/images/sub.png',
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}