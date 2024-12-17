import 'package:flutter/material.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/dimensions.dart';

class SuccessDialog extends StatefulWidget {
  final String? title, subTitle, buttonName;
  final Widget? moved;
  const SuccessDialog({Key? key, this.title, this.subTitle, this.buttonName, this.moved}) : super(key:
key);
  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}
class _SuccessDialogState extends State<SuccessDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
                'assets/images/tik.png',
              height: 60,
              width: 60,
            ),
            Text(
              '${widget.title}!!',
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  color: CustomColor.primary,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.subTitle ?? "",
              style: TextStyle(
                  fontSize: Dimensions.largeTextSize,
                  color: CustomColor.primary,
              ),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius))
                ),
                child: Center(
                  child: Text(
                    widget.buttonName ?? "",
                    style: TextStyle(
                        fontSize: Dimensions.extraLargeTextSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget.moved ?? SizedBox()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
