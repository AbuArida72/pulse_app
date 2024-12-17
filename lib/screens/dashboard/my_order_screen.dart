import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/widgets/header_widget.dart';
import 'package:pulse/data/order.dart';
import 'package:pulse/screens/order_status.dart';
class MyOrderScreen extends StatefulWidget {
  @override
  _MyOrderScreenState createState() => _MyOrderScreenState();
}
class _MyOrderScreenState extends State<MyOrderScreen> {
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
              HeaderWidget(name: Strings.myOrders,),
              bodyWidget(context),
            ],
          ),
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
          itemCount: OrderList.list().length,
          itemBuilder: (context, index) {
            Order order = OrderList.list()[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: GestureDetector(
                child: Card(
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
                                    order.image ?? "",
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
                                          order.name ?? "",
                                          style: TextStyle(
                                              fontSize: Dimensions.largeTextSize,
                                              color: Colors.black
                                          ),
                                        ),
                                        SizedBox(width: Dimensions.widthSize * 0.5,),
                                        Text(
                                          '${order.volumeList![1]}mg',
                                          style: TextStyle(
                                              fontSize: Dimensions.smallTextSize,
                                              color: Colors.black
                                          ),
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'USD ${order.newPrice}',
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
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: CustomColor.secondary,
                                borderRadius: BorderRadius.circular(15)
                              ),
                              child: Center(
                                child: Text(
                                  order.status ?? ""
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                      OrderStatusScreen(product: order,)));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
