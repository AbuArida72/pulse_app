import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/custom_style.dart';
import 'package:pulse/helpers/strings.dart';
import 'package:pulse/bottomsheet/add_card_bottomsheet.dart';
import 'package:pulse/dialog/success_dialog.dart';
class PaymentMethodBottomSheet extends StatefulWidget {
  @override
  _PaymentMethodBottomSheetState createState() => _PaymentMethodBottomSheetState();
}
enum SingingCharacter {card1, card2, card3, card4, card5}
class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  SingingCharacter _character = SingingCharacter.card1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      color: Color(0xFF737373),
      child: new Container(
          decoration: new BoxDecoration(
              color: Colors.white,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.selectPaymentMethod,
            style: TextStyle(
              fontSize: Dimensions.largeTextSize,
              color: Colors.black
            ),
          ),
          SizedBox(height: Dimensions.heightSize * 2,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Radio(
                  value: SingingCharacter.card1,
                  toggleable : true,
                  autofocus : true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                      print('value: '+_character.toString());
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.mastercard.toUpperCase(),
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                        fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                  child: Image.asset(
                      'assets/images/card/mastercard.png',
                    height: 30,
                  )
              )
            ],
          ),
          Divider(color: Colors.grey,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Radio(
                  value: SingingCharacter.card2,
                  toggleable : true,
                  autofocus : true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                      print('value: '+_character.toString());
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.discover,
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/card/discover.png',
                    height: 30,
                  )
              )
            ],
          ),
          Divider(color: Colors.grey,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Radio(
                  value: SingingCharacter.card3,
                  toggleable : true,
                  autofocus : true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                      print('value: '+_character.toString());
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.visaCard,
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/card/visa.png',
                    height: 30,
                  )
              )
            ],
          ),
          Divider(color: Colors.grey,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Radio(
                  value: SingingCharacter.card4,
                  toggleable : true,
                  autofocus : true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                      print('value: '+_character.toString());
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.payPal,
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/card/paypal.png',
                    height: 30,
                  )
              )
            ],
          ),
          Divider(color: Colors.grey,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Radio(
                  value: SingingCharacter.card5,
                  toggleable : true,
                  autofocus : true,
                  groupValue: _character,
                  onChanged: ( value) {
                    setState(() {
                      _character = value!;
                      print('value: '+_character.toString());
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.cashOnDelivery,
                      style: CustomStyle.textStyle,
                    ),
                    SizedBox(height: Dimensions.heightSize * 0.5,),
                    Text(
                      Strings.payFromMastercard,
                      style: TextStyle(
                          fontSize: Dimensions.smallTextSize
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/card/cod.png',
                    height: 30,
                  )
              )
            ],
          ),
        ],
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
              Strings.confirmPayment.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
        onTap: () {
          if(_character.toString() != 'SingingCharacter.card5'){
            print('go to add');
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (builder) {
                  return AddCardBottomSheet();
                });
          }else {
            print('show dialog');
            showSuccessDialog(context);
          }
        },
      ),
    );
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