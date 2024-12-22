import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';

class OrderStatusScreen extends StatefulWidget {
  final dynamic product;
  const OrderStatusScreen({Key? key, this.product}) : super(key: key);
  @override
  _OrderStatusScreenState createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          Strings.orderStatus,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: CustomColor.primary,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.marginSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Dimensions.heightSize * 2),
              buildHeader(),
              SizedBox(height: Dimensions.heightSize * 2),
              statusWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              orderTimelineWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              productWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              orderSummaryWidget(context),
              SizedBox(height: Dimensions.heightSize * 2),
              paymentStatusWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.local_shipping,
            color: CustomColor.primary,
            size: 50,
          ),
          SizedBox(height: Dimensions.heightSize * 0.5),
          Text(
            "Track your order",
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: Dimensions.heightSize * 0.5),
          Text(
            "Order #12345",
            style: TextStyle(
              fontSize: Dimensions.defaultTextSize,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget statusWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildStatusStep("Pending", true),
        buildDivider(),
        buildStatusStep("Processing", true),
        buildDivider(),
        buildStatusStep("Shipped", false),
        buildDivider(),
        buildStatusStep("Delivered", false),
      ],
    );
  }

  Widget buildStatusStep(String title, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: isActive ? CustomColor.primary : Colors.grey.shade300,
          child: Icon(
            Icons.check,
            color: isActive ? Colors.white : Colors.grey.shade600,
            size: 16,
          ),
        ),
        SizedBox(height: Dimensions.heightSize * 0.5),
        Text(
          title,
          style: TextStyle(
            fontSize: Dimensions.smallTextSize,
            color: isActive ? Colors.black : Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildDivider() {
    return Container(
      height: 2,
      width: 30,
      color: Colors.grey.shade300,
    );
  }

  Widget orderTimelineWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.orderTimeline,
          style: TextStyle(
            fontSize: Dimensions.largeTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        buildTimelineEntry("31 Jan", "12:30 PM", Strings.shipped),
        buildTimelineEntry("28 Jan", "10:00 AM", Strings.picked),
        buildTimelineEntry("26 Jan", "08:00 AM", Strings.processing),
        buildTimelineEntry("23 Jan", "06:00 PM", Strings.confirmed),
      ],
    );
  }

  Widget buildTimelineEntry(String date, String time, String status) {
    return Row(
      children: [
        Column(
          children: [
            Icon(
              Icons.circle,
              size: 10,
              color: CustomColor.primary,
            ),
            Container(
              height: 50,
              width: 2,
              color: Colors.grey.shade300,
            ),
          ],
        ),
        SizedBox(width: Dimensions.widthSize),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                fontSize: Dimensions.smallTextSize,
                color: Colors.grey,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontSize: Dimensions.smallTextSize,
                color: Colors.grey,
              ),
            ),
            Text(
              status,
              style: TextStyle(
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget productWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.product,
          style: TextStyle(
            fontSize: Dimensions.largeTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          elevation: 3,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: CustomColor.secondary,
              backgroundImage: widget.product?.image != null
                  ? AssetImage(widget.product.image)
                  : null,
            ),
            title: Text(
              widget.product?.name ?? "Product Name",
              style: TextStyle(
                fontSize: Dimensions.defaultTextSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              "USD ${widget.product?.newPrice ?? "0.00"}",
              style: TextStyle(
                fontSize: Dimensions.smallTextSize,
                color: CustomColor.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget orderSummaryWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.orderSummery,
          style: TextStyle(
            fontSize: Dimensions.largeTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildSummaryRow(Strings.subTotal, "\$235"),
                buildSummaryRow(Strings.deliveryCharge, "\$15"),
                Divider(color: Colors.grey),
                buildSummaryRow(Strings.total, "\$250", isBold: true),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: Dimensions.defaultTextSize,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: Dimensions.defaultTextSize,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget paymentStatusWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.paymentStatus,
          style: TextStyle(
            fontSize: Dimensions.largeTextSize,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: Dimensions.heightSize),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Strings.paid,
                  style: TextStyle(
                    fontSize: Dimensions.defaultTextSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}