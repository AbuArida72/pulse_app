import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/data/order.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pulse/bottomsheet/payment_method_bottomsheet.dart';
class CheckoutInformationScreen extends StatefulWidget {
  @override
  _CheckoutInformationScreenState createState() => _CheckoutInformationScreenState();
}
class _CheckoutInformationScreenState extends State<CheckoutInformationScreen> {
  File? file;
  Order? order;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(Strings.checkOut),),
        body: SingleChildScrollView(
          child: Column(
            children: [
              bodyWidget(context),
              placeOrderWidget(context)
            ],
          ),
        ),
      ),
    );
  }
  bodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100, bottom: 100),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            deliveryAddressWidget(context),
            SizedBox(height: Dimensions.heightSize * 2,),
            contactNumberWidget(context),
            SizedBox(height: Dimensions.heightSize * 2,),
            uploadPrescriptionWidget(context),
            SizedBox(height: Dimensions.heightSize * 2,),
            productWidget(context),
            SizedBox(height: Dimensions.heightSize * 2,),
            productListWidget(context)
          ],
        ),
      )
    );
  }
  deliveryAddressWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.deliveryAddress,
                style: TextStyle(
                  fontSize: Dimensions.largeTextSize,
                  color: Colors.black
                ),
              ),
              Text(
                Strings.change.toUpperCase(),
                style: TextStyle(
                  fontSize: Dimensions.largeTextSize,
                    color: CustomColor.primary
                ),
              ),
            ],
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.heightSize,
                bottom: Dimensions.heightSize,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.home,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.demoName,
                                style: TextStyle(
                                  fontSize: Dimensions.largeTextSize,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Text(
                                Strings.demoAddress,
                                style: TextStyle(
                                  fontSize: Dimensions.defaultTextSize,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15)
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  contactNumberWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.contactNumber,
            style: TextStyle(
                fontSize: Dimensions.largeTextSize,
            ),
          ),
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Dimensions.heightSize,
                bottom: Dimensions.heightSize,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Icon(
                      Icons.call,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Strings.demoNumber,
                                style: TextStyle(
                                  fontSize: Dimensions.largeTextSize,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(15)
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  uploadPrescriptionWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  Container(
                    height: 30,
                    width: 30,
                    child: file != null ? Image.file(file!)
                        : Image.asset('assets/images/documents.png'),
                  ),
                  GestureDetector(
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15)
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    onTap: () {
                      _openImageSourceOptions();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _openImageSourceOptions() {
    return showDialog(context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Icon(Icons.camera_alt, size: 40.0, color: Colors.blue,),
                  onTap: (){
                    Navigator.of(context).pop();
                    _chooseFromCamera();
                  },
                ),
                GestureDetector(
                  child: Icon(Icons.photo, size: 40.0, color: Colors.green,),
                  onTap: (){
                    Navigator.of(context).pop();
                    _chooseFromGallery();
                  },
                ),
              ],
            ),
          );
        });
  }
  void _chooseFromGallery() async{
    final ImagePicker picker = ImagePicker();
    file = picker.pickImage(source: ImageSource.gallery) as File?;
    if (file == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No File Selected'))
      );
    }else{
    }
  }
  _chooseFromCamera() async{
    print('open camera');
    final ImagePicker picker = ImagePicker();
    file = picker.pickImage(source: ImageSource.gallery) as File?;
    print('picked camera');
    if (file == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No Capture Image'))
      );
    }else{
    }
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
                          'assets/images/bag/1.png',
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
                                'Betulin Vita',
                                style: TextStyle(
                                    fontSize: Dimensions.largeTextSize,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: Dimensions.widthSize * 0.5,),
                              Text(
                                '150mg',
                                style: TextStyle(
                                    fontSize: Dimensions.smallTextSize,
                                    color: Colors.black
                                ),
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Text(
                            'USD 64',
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
  productListWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.productList,
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
                            color: CustomColor.primary,
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
  placeOrderWidget(BuildContext context) {
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
                      'USD 250.00',
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
                        Strings.placeOrder.toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (builder) {
                          return new PaymentMethodBottomSheet();
                        });
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
