import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/dialog/success_dialog.dart';
class AddCardBottomSheet extends StatefulWidget {
  @override
  _AddCardBottomSheetState createState() => _AddCardBottomSheetState();
}
enum SingingCharacter {card1, card2, card3, card4, card5}
class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String expDate = 'exp date';
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      color: Color(0xFF737373),
      child: new Container(
          decoration: new BoxDecoration(
              color: CustomColor.secondary,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0), topRight: const Radius.circular(20.0))
          ),
          child: Stack(
            children: [
              paymentMethodWidget(context),
              confirmPaymentWidget(context)
            ],
          )
      ),
    );
  }
  paymentMethodWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimensions.marginSize,
        right: Dimensions.marginSize,
        top: Dimensions.heightSize,
      ),
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.cardNumber,
                style: CustomStyle.textStyle,
              ),
              SizedBox(height: Dimensions.heightSize * 0.5),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: numberController,
                validator: (value){
                  if(value!.isEmpty){
                    return Strings.pleaseFillOutTheField;
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoCardNumber,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              Text(
                Strings.cardHolderName,
                style: CustomStyle.textStyle,
              ),
              SizedBox(height: Dimensions.heightSize * 0.5),
              TextFormField(
                style: CustomStyle.textStyle,
                controller: nameController,
                validator: (value){
                  if(value!.isEmpty){
                    return Strings.pleaseFillOutTheField;
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: Strings.demoName,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  labelStyle: CustomStyle.textStyle,
                  focusedBorder: CustomStyle.focusBorder,
                  enabledBorder: CustomStyle.focusErrorBorder,
                  focusedErrorBorder: CustomStyle.focusErrorBorder,
                  errorBorder: CustomStyle.focusErrorBorder,
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: CustomStyle.textStyle,
                ),
              ),
              SizedBox(height: Dimensions.heightSize),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.expirationDate,
                          style: CustomStyle.textStyle,
                        ),
                        SizedBox(height: Dimensions.heightSize * 0.5),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                              height: 48.0,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                  border: Border.all(color: Colors.black.withOpacity(0.1)),
                                  borderRadius: BorderRadius.all(Radius.circular(24.0))
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    expDate,
                                    style: CustomStyle.textStyle,
                                  ),
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: Dimensions.heightSize),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.cvv,
                          style: CustomStyle.textStyle,
                        ),
                        SizedBox(height: Dimensions.heightSize * 0.5),
                        TextFormField(
                          style: CustomStyle.textStyle,
                          controller: cvvController,
                          validator: (value){
                            if(value!.isEmpty){
                              return Strings.pleaseFillOutTheField;
                            }else{
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            labelText: '123',
                            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                            labelStyle: CustomStyle.textStyle,
                            focusedBorder: CustomStyle.focusBorder,
                            enabledBorder: CustomStyle.focusErrorBorder,
                            focusedErrorBorder: CustomStyle.focusErrorBorder,
                            errorBorder: CustomStyle.focusErrorBorder,
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: CustomStyle.textStyle,
                          ),
                        ),
                        SizedBox(height: Dimensions.heightSize),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
      ),
    );
  }
  confirmPaymentWidget(BuildContext context) {
    return Positioned(
      bottom: Dimensions.heightSize,
      left: Dimensions.marginSize * 3,
      right: Dimensions.marginSize * 3,
      child: GestureDetector(
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: CustomColor.primary,
              borderRadius: BorderRadius.circular(Dimensions.radius * 2)
          ),
          child: Center(
            child: Text(
              Strings.payNow.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () {
          showSuccessDialog(context);
        },
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        expDate = "${selectedDate.toLocal()}".split(' ')[0];
        print('date: '+expDate);
      });
  }
  Future<bool> showSuccessDialog(BuildContext context) async {
    return (await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => SuccessDialog(
        title: Strings.success,
        subTitle: Strings.nowCheckYourEmail,
        buttonName: Strings.ok,
      ),
    )) ?? false;
  }
}