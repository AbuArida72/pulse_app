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
            color: CustomColor.secondary
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.marginSize * 2, right: Dimensions
                        .marginSize * 2),
                    child: Text(
                      Strings.title,
                      style: TextStyle(
                          fontSize: Dimensions.extraLargeTextSize * 1.5,
                          color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.marginSize * 2, right: Dimensions
                        .marginSize * 2),
                    child: Text(
                      Strings.slogan,
                      style: TextStyle(
                          fontSize: Dimensions.largeTextSize,
                          color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize * 6,),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.marginSize * 2, right: Dimensions
                        .marginSize * 2),
                    child: GestureDetector(
                      child: Container(
                        height: Dimensions.buttonHeight,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: CustomColor.primary,
                            borderRadius: BorderRadius.circular(Dimensions.radius * 3)
                        ),
                        child: Center(
                          child: Text(
                            Strings.createAnAccount.toUpperCase(),
                            style: TextStyle(
                              fontSize: Dimensions.largeTextSize,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpScreen
                          ()));
                      },
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize,),
                  Padding(
                    padding: const EdgeInsets.only(left: Dimensions.marginSize * 2, right: Dimensions
                        .marginSize * 2),
                    child: GestureDetector(
                      child: Container(
                        height: Dimensions.buttonHeight,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: CustomColor.primary.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(Dimensions.radius * 3)
                        ),
                        child: Center(
                          child: Text(
                            Strings.signIn.toUpperCase(),
                            style: TextStyle(
                                fontSize: Dimensions.largeTextSize,
                                color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                            SignInScreen
                          ()));
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
                  'assets/images/onboard/sub.png',
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
