import 'package:flutter/material.dart';
import 'package:pulse/helpers/dimensions.dart';
import 'package:pulse/helpers/colors.dart';
class BackWidget extends StatefulWidget {
  final String? name;
  const BackWidget({Key? key, this.name}) : super(key: key);
  @override
  _BackWidgetState createState() => _BackWidgetState();
}
class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimensions.radius * 2),
            bottomRight: Radius.circular(Dimensions.radius * 2)
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
        padding: const EdgeInsets.only(left: Dimensions.marginSize, right: Dimensions.marginSize),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Icon(
                Icons.arrow_back_outlined,
                color: CustomColor.primary,
                size: 30,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            SizedBox(width: Dimensions.widthSize,),
            Text(
              widget.name ?? "",
              style: TextStyle(
                  fontSize: Dimensions.extraLargeTextSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),
            )
          ],
        ),
      ),
    );
  }
}
