import 'package:flutter/material.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/widgets/back_widget.dart';
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
              BackWidget(name: Strings.signInAccount,),
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
                        hintText: Strings.typeEmail,
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
                  Strings.signIn.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  DashboardScreen()));
            },
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.ifYouHaveNoAccount,
              style: CustomStyle.textStyle,
            ),
            GestureDetector(
              child: Text(
                Strings.createAccount.toUpperCase(),
                style: TextStyle(
                  color: CustomColor.primary,
                  fontWeight: FontWeight.bold
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  SignUpScreen()));
              },
            )
          ],
        )
      ],
    );
  }
}
