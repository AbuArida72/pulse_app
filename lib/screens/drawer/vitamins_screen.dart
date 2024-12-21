import 'package:flutter/material.dart';

import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/data/VitaminList.dart';

class VitaminsScreen extends StatefulWidget {
  @override
  VitaminsScreenState createState() => VitaminsScreenState();
}

class VitaminsScreenState extends State<VitaminsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(Strings.vitaminSupplement),),
      body: SingleChildScrollView(
          child: Column(
            children: [
              bodyWidget(context),
            ],
          ),
        ),
      );
  }

  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: VitaminList.list().length,
          itemBuilder: (context, index) {
            Vitamin vitamin = VitaminList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Dimensions.marginSize,
                    right: Dimensions.marginSize,
                  ),
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: Dimensions.marginSize,
                          right: Dimensions.marginSize,
                        top: Dimensions.heightSize,
                        bottom: Dimensions.heightSize,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                      vitamin.image ?? "",
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
                                          Text(
                                            vitamin.name ?? "",
                                            style: TextStyle(
                                                fontSize: Dimensions.largeTextSize,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(width: Dimensions.widthSize * 0.5,),
                                        ],
                                      ),
                                      Text(
                                        'USD ${vitamin.Price}',
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
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () {

                },
              ),
            );
          },
        ),
      ),
    );
  }

}
