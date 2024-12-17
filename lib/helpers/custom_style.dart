import 'package:flutter/material.dart';
import 'dimensions.dart';

class CustomStyle {
  static var textStyle = TextStyle(
      color: Colors.grey,
      fontSize: 16.0
  );
  static var hintTextStyle = TextStyle(
      color: Colors.grey.withOpacity(0.5),
      fontSize: 16.0
  );
  static var listStyle = TextStyle(
      color: Colors.black,
      fontSize: 16.0,
  );
  static var defaultStyle = TextStyle(
      color: Colors.black,
      fontSize: Dimensions.largeTextSize
  );
  static var focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius * 3),
    borderSide: BorderSide(color: Colors.white),
  );
  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.radius * 3),
    borderSide: BorderSide(color: Colors.white),
  );
  static var searchBox = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
    borderSide: BorderSide(color: Colors.black),
  );
}