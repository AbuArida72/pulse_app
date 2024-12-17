import 'package:flutter/material.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/widgets/back_widget.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _toggleVisibility = true;
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              BackWidget(name: Strings.createAnAccount,),
              bodyWidget(context)
            ],
          ),
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
                right: Dimensions.marginSize
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    elevation: 40.0,
                    shadowColor: CustomColor.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value){
                        if(value!.isEmpty){
                          return Strings.pleaseFillOutTheField;
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.demoEmail,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        filled: true,
                        fillColor: CustomColor.accent,
                        hintStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        prefixIcon: Icon(
                          Icons.mail,
                          color: CustomColor.primary,
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize,),
                  Material(
                    elevation: 40.0,
                    shadowColor: CustomColor.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: passwordController,
                      validator: (value){
                        if(value!.isEmpty){
                          return Strings.pleaseFillOutTheField;
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.typePassword,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        filled: true,
                        fillColor: CustomColor.accent,
                        hintStyle: CustomStyle.textStyle,
                        prefixIcon: Icon(
                            Icons.lock,
                          color: CustomColor.primary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _toggleVisibility = !_toggleVisibility;
                            });
                          },
                          icon: _toggleVisibility
                              ? Icon(
                            Icons.visibility_off,
                            color: CustomColor.primary,
                          )
                              : Icon(
                            Icons.visibility,
                            color: CustomColor.primary,
                          ),
                        ),
                      ),
                      obscureText: _toggleVisibility,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Material(
                    elevation: 40.0,
                    shadowColor: CustomColor.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    child: TextFormField(
                      style: CustomStyle.textStyle,
                      controller: confirmPasswordController,
                      validator: (value){
                        if(value!.isEmpty){
                          return Strings.pleaseFillOutTheField;
                        }else{
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText: Strings.typePassword,
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                        labelStyle: CustomStyle.textStyle,
                        focusedBorder: CustomStyle.focusBorder,
                        enabledBorder: CustomStyle.focusErrorBorder,
                        focusedErrorBorder: CustomStyle.focusErrorBorder,
                        errorBorder: CustomStyle.focusErrorBorder,
                        filled: true,
                        fillColor: CustomColor.accent,
                        prefixIcon: Icon(
                            Icons.lock,
                          color: CustomColor.primary,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _toggleVisibility = !_toggleVisibility;
                            });
                          },
                          icon: _toggleVisibility
                              ? Icon(
                            Icons.visibility_off,
                            color: CustomColor.primary,
                          )
                              : Icon(
                            Icons.visibility,
                            color: CustomColor.primary,
                          ),
                        ),
                        hintStyle: CustomStyle.textStyle,
                      ),
                      obscureText: _toggleVisibility,
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize),
                ],
              ),
            )
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: GestureDetector(
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: CustomColor.primary,
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius * 3))
              ),
              child: Center(
                child: Text(
                  Strings.createAnAccount.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Text(
          Strings.orLoginWith,
          style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.largeTextSize,
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              child: Container(
                height: Dimensions.buttonHeight,
                width: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius * 3)
                ),
                child: Image.asset(
                    'assets/images/google.png'
                ),
              ),
            ),
            SizedBox(width: Dimensions.widthSize,),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              child: Container(
                height: Dimensions.buttonHeight,
                width: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius * 3)
                ),
                child: Image.asset(
                    'assets/images/facebook.png'
                ),
              ),
            ),
            SizedBox(width: Dimensions.widthSize,),
            Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(Dimensions.radius * 3),
              child: Container(
                height: Dimensions.buttonHeight,
                width: Dimensions.buttonHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius * 3)
                ),
                child: Image.asset(
                    'assets/images/twitter.png'
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: Dimensions.heightSize * 2),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "By clicking sign up you agree to the following ",
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
                        decoration: TextDecoration.underline
                    ),
                  ),
                  onTap: () {
                    print('go to privacy url');
                    _showTermsConditions();
                  },
                ),
                Text(
                  " with out reservation",
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
                  color: CustomColor.primary,
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                /*Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  SignInScreen()));*/
              },
            )
          ],
        )
      ],
    );
  }
  Future<bool> _showTermsConditions() async {
    return (await showDialog(
      context: context,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: CustomColor.primary,
        child: Stack(
          children: [
            Positioned(
                top: -35.0,
                left: -50.0,
                child: Image.asset(
                    'assets/images/splash_logo.png'
                )
            ),
            Positioned(
                right: -35.0,
                bottom: -20.0,
                child: Image.asset(
                    'assets/images/splash_logo.png'
                )
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: Dimensions.defaultPaddingSize * 2,
                  bottom: Dimensions.defaultPaddingSize * 2
              ),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: AlertDialog(
                    content: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 45,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Dimensions.heightSize * 2,),
                                Text(
                                  Strings.ourPolicyTerms,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accent,
                                          fontSize: Dimensions.extraLargeTextSize
                                      ),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Expanded(
                                      child: Text(
                                        'simply random text. It has roots in a piece of classical Latin literature ',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accent,
                                          fontSize: Dimensions.extraLargeTextSize
                                      ),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Expanded(
                                      child: Text(
                                        'Distracted by the readable content of a page when looking at its layout.',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '•',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: CustomColor.accent,
                                          fontSize: Dimensions.extraLargeTextSize
                                      ),
                                    ),
                                    SizedBox(width: 5.0,),
                                    Expanded(
                                      child: Text(
                                        'Available, but the majority have suffered alteration',
                                        style: CustomStyle.textStyle,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize * 2,),
                                Text(
                                  'When do we contact information ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                                SizedBox(height: Dimensions.heightSize * 2,),
                                Text(
                                  'Do we use cookies ?',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: Dimensions.largeTextSize,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: Dimensions.heightSize),
                                Text(
                                  'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old',
                                  style: CustomStyle.textStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    child: Container(
                                      height: 35.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          color: CustomColor.secondary,
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                                      ),
                                      child: Center(
                                        child: Text(
                                          Strings.decline,
                                          style: TextStyle(
                                              color: CustomColor.primary,
                                              fontSize: Dimensions.defaultTextSize,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  SizedBox(width: 10.0,),
                                  GestureDetector(
                                    child: Container(
                                      height: 35.0,
                                      width: 100.0,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primary,
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                                      ),
                                      child: Center(
                                        child: Text(
                                          Strings.agree,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: Dimensions.defaultTextSize,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    )) ?? false;
  }
}
