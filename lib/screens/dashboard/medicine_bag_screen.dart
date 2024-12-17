import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/widgets/header_widget.dart';
import 'package:pulse/widgets/add_quantity_widget.dart';
import 'package:pulse/data/bag.dart';
import 'package:pulse/screens/checkout_screen.dart';
class MedicineBagScreen extends StatefulWidget {
  @override
  _MedicineBagScreenState createState() => _MedicineBagScreenState();
}
class _MedicineBagScreenState extends State<MedicineBagScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              HeaderWidget(name: Strings.medicineBag,),
              bodyWidget(context),
              checkOutWidget(context)
            ],
          ),
        ),
      ),
    );
  }
  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, bottom: 100),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: BagList.list().length,
          itemBuilder: (context, index) {
            Bag bag = BagList.list()[index];
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: Dimensions.marginSize,
                  top: Dimensions.heightSize,
                  bottom: Dimensions.heightSize,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 2,
                      child: IconButton(
                          icon: Icon(
                            Icons.delete
                          ),
                          onPressed: null
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: CustomColor.secondary,
                                  borderRadius: BorderRadius.circular(25)
                              ),
                              child: Image.asset(
                                bag.image ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: Dimensions.widthSize,),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        bag.name ?? "",
                                        style: TextStyle(
                                            fontSize: Dimensions.largeTextSize,
                                            color: Colors.black
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.widthSize * 0.5,),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        '${bag.volumeList![1]}mg',
                                        style: TextStyle(
                                            fontSize: Dimensions.smallTextSize,
                                            color: Colors.black
                                        ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'USD ${bag.newPrice}',
                                  style: TextStyle(
                                      fontSize: Dimensions.defaultTextSize,
                                      color: CustomColor.primary
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Dimensions.widthSize,),
                    Expanded(
                      flex: 2,
                      child: AddQuantityWidget()
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  checkOutWidget(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 2),
            topRight: Radius.circular(Dimensions.radius * 2),
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
          padding: const EdgeInsets.only(
            left: Dimensions.marginSize,
            right: Dimensions.marginSize,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'USD 276.00',
                      style: TextStyle(
                          color: CustomColor.primary,
                          fontSize: Dimensions.largeTextSize,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      Strings.total,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.largeTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                        color: CustomColor.primary,
                        borderRadius: BorderRadius.circular(Dimensions.radius * 2)
                    ),
                    child: Center(
                      child: Text(
                        Strings.checkOut.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        CheckoutInformationScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
