import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';

class OrderStatusScreen extends StatefulWidget {
  final dynamic? product;
  const OrderStatusScreen({Key? key, this.product}) : super(key: key);
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}
class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(Strings.orderStatus),),
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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            statusWidget(context),
            Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.heightSize,
                bottom: Dimensions.heightSize,
                left: Dimensions.marginSize,
                right: Dimensions.marginSize,
              ),
              child: Divider(color: Colors.grey,),
            ),
            orderTimelineWidget(context),
            SizedBox(height: Dimensions.heightSize,),
            productWidget(context),
            SizedBox(height: Dimensions.heightSize,),
            orderSummeryWidget(context),
            SizedBox(height: Dimensions.heightSize,),
            paymentStatusWidget(context),
            SizedBox(height: Dimensions.heightSize,),
          ],
        ),
      )
    );
  }
  statusWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: CustomColor.primary,
                    borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5,),
                Text(
                  Strings.pending,
                  style: TextStyle(
                    fontSize: Dimensions.smallTextSize
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5,),
                Text(
                  Strings.pending,
                  style: TextStyle(
                      fontSize: Dimensions.smallTextSize
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5,),
                Text(
                  Strings.pending,
                  style: TextStyle(
                      fontSize: Dimensions.smallTextSize
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5,),
                Text(
                  Strings.pending,
                  style: TextStyle(
                      fontSize: Dimensions.smallTextSize
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5,),
                Text(
                  Strings.pending,
                  style: TextStyle(
                      fontSize: Dimensions.smallTextSize
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: CustomColor.primary,
                      borderRadius: BorderRadius.circular(Dimensions.radius)
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Dimensions.heightSize * 0.5,),
                Text(
                  Strings.pending,
                  style: TextStyle(
                      fontSize: Dimensions.smallTextSize
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  orderTimelineWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.orderTimeline,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.largeTextSize
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '31 jan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.smallTextSize
                      ),
                    ),
                    Text(
                      '12:30pm',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: CustomColor.primary,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    Container(height: 80, child: VerticalDivider(color: Colors.red))
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.shipped,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.defaultTextSize
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '28 jan',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.smallTextSize
                      ),
                    ),
                    Text(
                      '12:30pm',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: CustomColor.primary,
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    Container(height: 80, child: VerticalDivider(color: Colors.red))
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.picked,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.defaultTextSize
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '26 jan',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                    Text(
                      '1:30pm',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: CustomColor.primary,
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    Container(height: 80, child: VerticalDivider(color: Colors.red))
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.processing,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.defaultTextSize
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '23 jan',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                    Text(
                      '2:30pm',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: CustomColor.primary,
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                    Container(height: 80, child: VerticalDivider(color: Colors.red))
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.confirmed,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.defaultTextSize
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '20 jan',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                    Text(
                      '07:30pm',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                          color: CustomColor.primary,
                          borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.pending,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.defaultTextSize
                      ),
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  productWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.product,
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Card(
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
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: CustomColor.secondary,
                            borderRadius: BorderRadius.circular(25)
                        ),
                        child: Image.asset(
                          widget.product?.image ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: Dimensions.widthSize,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.product?.name ?? "",
                                style: TextStyle(
                                    fontSize: Dimensions.largeTextSize,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: Dimensions.widthSize * 0.5,),
                              Text(
                                '${widget.product?.volumeList?[1]}mg',
                                style: TextStyle(
                                    fontSize: Dimensions.smallTextSize,
                                    color: Colors.black
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Text(
                            'USD ${widget.product?.newPrice}',
                            style: TextStyle(
                                fontSize: Dimensions.defaultTextSize,
                                color: CustomColor.primary
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  orderSummeryWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.orderSummery,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.largeTextSize
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.subTotal,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.defaultTextSize
                        ),
                      ),
                      Text(
                        '\$ 235',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.heightSize * 0.5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.deliveryCharge,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: Dimensions.defaultTextSize
                        ),
                      ),
                      Text(
                        '\$ 15',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.heightSize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.total,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize
                        ),
                      ),
                      Text(
                        '\$ 250',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.defaultTextSize,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  paymentStatusWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.paymentStatus,
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.largeTextSize
            ),
          ),
          SizedBox(height: Dimensions.heightSize,),
          Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.paid,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.defaultTextSize
                      ),
                    ),
                    Image.asset(
                      'assets/images/visa.png',
                      height: 25,
                      width: 35,
                    )
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
