import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';
import 'data.dart';
import 'package:pulse/screens/welcome_screen.dart';

class OnBoardScreen extends StatefulWidget {
  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  int totalPages = OnBoardingItems.loadOnboardItem().length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.secondary,
      body: PageView.builder(
        itemCount: totalPages,
          itemBuilder: (context, index){
          OnBoardingItem oi = OnBoardingItems.loadOnboardItem()[index];
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child:SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.heightSize, bottom: Dimensions
                          .heightSize * 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: CustomColor.primary,
                                  borderRadius: BorderRadius.circular(75)
                                ),
                                child: Image.asset(
                                  oi.image ?? "",
                                  //fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                ),
                              ),
                              Positioned(
                                top: -50,
                                left: -60,
                                child: Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: CustomColor.primary,
                                      borderRadius: BorderRadius.circular(35)
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: Dimensions.heightSize * 3,),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: Dimensions.marginSize * 2.5, right:
                                Dimensions.marginSize * 2.5),
                                child: Text(
                                  oi.title ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.extraLargeTextSize * 1.5,
                                      fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.heightSize * 3,),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Align(
                              alignment: Alignment.center,
                              child: index != (totalPages - 1) ? Padding(
                                padding: const EdgeInsets.only(left: 40.0),
                                child: Container(
                                  width: 100.0,
                                  height: 12.0,
                                  child: ListView.builder(
                                    itemCount: totalPages,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, i){
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Container(
                                          width: index == i ? 30 : 20.0,
                                          decoration: BoxDecoration(
                                              color: index == i ? CustomColor.primary :
                                              CustomColor.primary.withOpacity(0.5),
                                              borderRadius: BorderRadius.all(Radius.circular(5.0))
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                                  : GestureDetector(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    height: 50,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        color: CustomColor.primary,
                                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius
                                            * 0.5))
                                    ),
                                    child: Center(
                                      child: Text(
                                        Strings.getStarted.toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Dimensions.largeTextSize,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => IntroScreen()));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      right: -10,
                      left: -10,
                      child: Image.asset(
                          oi.subImage ?? "",
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              )
            );
          }),
    );
  }
}
