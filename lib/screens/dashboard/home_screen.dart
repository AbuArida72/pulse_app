import 'package:flutter/material.dart';
import 'package:pulse/data/care.dart';
import 'package:pulse/data/category.dart';
import 'package:pulse/data/supplement.dart';
import 'package:pulse/data/vitamin.dart';
import 'package:pulse/screens/authentication/sign_in_screen.dart';
import 'package:pulse/screens/drawer/prescription_upload_screen.dart';
import 'package:pulse/screens/drawer/supplements_screen.dart';
import 'package:pulse/screens/drawer/vitamins_screen.dart';
import 'package:pulse/screens/medicine_screen.dart';
import 'package:pulse/screens/profile_screen.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  child: profileWidget(context),
                  decoration: BoxDecoration(
                    color: CustomColor.primary,
                  ),
                ),
                ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  title: Text(
                    Strings.myProfile,
                    style: CustomStyle.listStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        MyProfileScreen
                          ()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                  ),
                  child: Divider(color: Colors.grey,),
                ),
                ListTile(
                  leading: Icon(
                    Icons.upload_file,
                    color: Colors.black,
                  ),
                  title: Text(
                    Strings.uploadPrescription,
                    style: CustomStyle.listStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        PrescriptionUploadScreen
                          ()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                  ),
                  child: Divider(color: Colors.grey,),
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  title: Text(
                    Strings.supplements,
                    style: CustomStyle.listStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        SupplementsScreen
                          ()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                  ),
                  child: Divider(color: Colors.grey,),
                ),
                ListTile(
                  leading: Icon(
                    Icons.support_agent,
                    color: Colors.black,
                  ),
                  title: Text(
                    Strings.helpSupport,
                    style: CustomStyle.listStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                  ),
                  child: Divider(color: Colors.grey,),
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.black,
                  ),
                  title: Text(
                    Strings.logout,
                    style: CustomStyle.listStyle,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        SignInScreen
                          ()));
                  },
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            headerWidget(context),
            Padding(
              padding: EdgeInsets.only(top: 85),
              child: bodyWidget(context),
            ),
          ],
        ),
      ),
    );
  }
  profileWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.heightSize * 3,),
      child: ListTile(
        leading: Image.asset(
          'assets/images/user.png',
        ),
        title: Text(
          Strings.demoName,
          style: TextStyle(
              color: Colors.white,
              fontSize: Dimensions.largeTextSize,
              fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Text(
          Strings.demoEmail,
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.defaultTextSize,
          ),
        ),
      ),
    );
  }
  headerWidget(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimensions.radius * 2),
              bottomRight: Radius.circular(Dimensions.radius * 2)
          ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              child: Image.asset(
                'assets/images/list.png'
              ),
              onTap: () {
                if(scaffoldKey.currentState!.isDrawerOpen){
                  scaffoldKey.currentState!.openEndDrawer();
                }else{
                  scaffoldKey.currentState!.openDrawer();
                }
              },
            ),
            Row(
              children: [
                GestureDetector(
                  child: Image.asset(
                      'assets/images/profile.png',
                    width: 37,
                    height: 37,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyProfileScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          shopByCategoryWidget(context),
          SizedBox(height: Dimensions.heightSize,),
          vitaminSupplementWidget(context),
          SizedBox(height: Dimensions.heightSize,),
          buyNowBanner(context),
          SizedBox(height: Dimensions.heightSize,),
          foodSupplementWidget(context),
          SizedBox(height: Dimensions.heightSize,),
          babyCareWidget(context),
          SizedBox(height: Dimensions.heightSize * 3,),
        ],
      ),
    );
  }
  shopByCategoryWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.shopByCategory,
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: Colors.black
                ),
              ),
              Text(
                Strings.seeAll,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: 120,
          child: ListView.builder(
            itemCount: CategoryList.list().length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Category category = CategoryList.list()[index];
              return Padding(
                padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                    .marginSize * 0.5),
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: CustomColor.secondary,
                        borderRadius: BorderRadius.circular(Dimensions.radius)
                      ),
                      child: Image.asset(
                          category.image ?? "",
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize,),
                    Text(
                      category.name ?? "",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: Dimensions.defaultTextSize
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
  vitaminSupplementWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.vitaminSupplement,
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: Colors.black
                ),
              ),
              GestureDetector(
                  child: Text(
                      Strings.seeAll,
                    style: TextStyle(
                      fontSize: Dimensions.defaultTextSize,
                      color: Colors.black
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VitaminsScreen()));
                  },
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: 120,
          child: ListView.builder(
            itemCount: VitaminList.list().length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Vitamin vitamin = VitaminList.list()[index];
              return Padding(
                padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                    .marginSize * 0.5),
                child: Container(
                  height: 120,
                  width: 130,
                  decoration: BoxDecoration(
                      color: CustomColor.secondary,
                      borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimensions.marginSize * 0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          vitamin.image ?? "",
                        ),
                        SizedBox(height: Dimensions.heightSize * 0.5,),
                        Text(
                          vitamin.name ?? "",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.largeTextSize
                          ),
                        ),
                        SizedBox(height: Dimensions.heightSize * 0.5,),
                        Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                            color: CustomColor.primary,
                            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                vitamin.rating ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.defaultTextSize
                                ),
                              ),
                              SizedBox(width: Dimensions.widthSize * 0.1,),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 15,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
  buyNowBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
      child: Container(
        height: 150.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: CustomColor.primary,
          borderRadius: BorderRadius.circular(Dimensions.radius * 2)
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.asset(
                'assets/images/delivery.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Strings.weWillDeliverYourMedicine,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.extraLargeTextSize
                    ),
                  ),
                  SizedBox(height: Dimensions.heightSize,),
                  Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                      color: CustomColor.secondary,
                      borderRadius: BorderRadius.circular(18.0)
                    ),
                    child: Center(
                      child: Text(
                        Strings.buyNow.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.largeTextSize
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  foodSupplementWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.foodSupplement,
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: Colors.black
                ),
              ),
              Text(
                Strings.seeAll,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: SupplementList.list().length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Supplement supplement = SupplementList.list()[index];
              return Padding(
                padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                    .marginSize * 0.5),
                child: GestureDetector(
                  child: Container(
                    child: Stack(
                      children: [
                        Container(
                          height: 150,
                          width: 220,
                          decoration: BoxDecoration(
                              color: CustomColor.secondary,
                              borderRadius: BorderRadius.circular(Dimensions.radius)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: Dimensions.marginSize * 0.5, right: Dimensions.marginSize * 0.5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      supplement.image ?? "",
                                      height: 60,
                                      width: 60,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 14 ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'USD ${supplement.newPrice}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: Dimensions.extraLargeTextSize
                                            ),
                                          ),
                                          SizedBox(height: Dimensions.heightSize * 0.5,),
                                          Text(
                                            '\$${supplement.oldPrice}',
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: Dimensions.largeTextSize,
                                                decoration: TextDecoration.lineThrough
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: Dimensions.heightSize * 0.5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          supplement.name ?? "",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: Dimensions.extraLargeTextSize
                                          ),
                                        ),
                                        SizedBox(height: Dimensions.heightSize * 0.5,),
                                        Text(
                                          'Bottle of ${supplement.piece} tablets',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: Dimensions.defaultTextSize
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 20,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          color: CustomColor.primary,
                                          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '4.5',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: Dimensions.defaultTextSize
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.widthSize * 0.1,),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 15,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            height: 25,
                            width: 60,
                            decoration: BoxDecoration(
                                color: CustomColor.primary,
                                borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius))
                            ),
                            child: Center(
                              child: Text(
                                '${supplement.discount}% OFF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.smallTextSize
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      MedicineDetailScreen(supplement: supplement))
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
    );
  }
  babyCareWidget(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.babyCare,
                style: TextStyle(
                    fontSize: Dimensions.extraLargeTextSize,
                    color: Colors.black
                ),
              ),
              Text(
                Strings.seeAll,
                style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    color: Colors.black
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimensions.heightSize,),
        Container(
          height: 150,
          child: ListView.builder(
            itemCount: CareList.list().length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Care care = CareList.list()[index];
              return Padding(
                padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions
                    .marginSize * 0.5),
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      width: 220,
                      decoration: BoxDecoration(
                          color: CustomColor.secondary,
                          borderRadius: BorderRadius.circular(Dimensions.radius)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: Dimensions.marginSize * 0.5, right: Dimensions.marginSize * 0.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Image.asset(
                                  care.image ?? "",
                                  height: 60,
                                  width: 60,
                                  fit: BoxFit.fitHeight,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'USD ${care.newPrice}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimensions.extraLargeTextSize
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.heightSize * 0.5,),
                                    Text(
                                      '\$${care.oldPrice}',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Dimensions.largeTextSize,
                                          decoration: TextDecoration.lineThrough
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: Dimensions.heightSize * 0.5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      care.name ?? "",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Dimensions.extraLargeTextSize
                                      ),
                                    ),
                                    SizedBox(height: Dimensions.heightSize * 0.5,),
                                    Text(
                                      'Bottle of ${care.volume}ml syrup',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: Dimensions.defaultTextSize
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  height: 20,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: CustomColor.primary,
                                      borderRadius: BorderRadius.circular(Dimensions.radius * 0.5)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '4.5',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Dimensions.defaultTextSize
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.widthSize * 0.1,),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 15,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    /*Positioned(
                      right: 0,
                      child: Container(
                        height: 25,
                        width: 60,
                        decoration: BoxDecoration(
                            color: CustomColor.primaryColor,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.radius))
                        ),
                        child: Center(
                          child: Text(
                            '${care.discount}% OFF',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: Dimensions.smallTextSize
                            ),
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}