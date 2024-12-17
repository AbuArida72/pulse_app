import 'package:flutter/material.dart';

import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/widgets/back_widget.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:pulse/bottomsheet/payment_method_bottomsheet.dart';

class PrescriptionUploadScreen extends StatefulWidget {

  @override
  _PrescriptionUploadScreenState createState() => _PrescriptionUploadScreenState();
}

class _PrescriptionUploadScreenState extends State<PrescriptionUploadScreen> {

  File? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Stack(
            children: [
              BackWidget(name: Strings.uploadPrescription,),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.deliveryAddress,
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: Colors.black
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          Text(
            Strings.uploadPrescription,
            style: TextStyle(
                fontSize: Dimensions.largeTextSize,
            ),
          ),
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
                    child: file != null ? Image.file(file ?? File(""))
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
    // ignore: deprecated_member_use
    final ImagePicker picker = ImagePicker();
    file = picker.pickImage(source: ImageSource.gallery) as File;

    if (file == null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No File Selected'))
      );
    }else{
      //_upload();
    }
  }
  _chooseFromCamera() async{
    print('open camera');
    //ignore: deprecated_member_use
    final ImagePicker picker = ImagePicker();
    file = (picker.pickImage(source: ImageSource.gallery) as File);

    print('picked camera');
    if (file == null){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No Capture Image'))
      );
    }else{
      //_upload();
    }
  }


  placeOrderWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.only(
          left: Dimensions.marginSize * 3,
          right: Dimensions.marginSize * 3,
        ),
        child: GestureDetector(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                color: CustomColor.primary,
                borderRadius: BorderRadius.circular(Dimensions.radius * 2)
            ),
            child: Center(
              child: Text(
                Strings.uploadNow.toUpperCase(),
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
      ),
    );
  }
}
