import 'package:pulse/helpers/app_export.dart';
import 'package:pulse/helpers/colors.dart';
import 'package:pulse/helpers/custom_style.dart';

// ignore: must_be_immutable
class CustomInput extends StatelessWidget {
  CustomInput({
    Key? key,
    this.title,
    this.alignment,
    this.width,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.titleStyle,
  }) : super(
          key: key,
        );
  final String? title;

  final Alignment? alignment;

  final double? width;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final int? maxLength;

  final String? hintText;

  String? initialValue;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final TextStyle? titleStyle;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Container(
            padding: EdgeInsets.only(bottom: 4),
            child: Text(title!,
                style: titleStyle ??
                    TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    )),
          ),
        alignment != null
            ? Align(
                alignment: alignment ?? Alignment.center,
                child: textFormFieldWidget,
              )
            : textFormFieldWidget,
      ],
    );
  }

  Widget get textFormFieldWidget => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          controller: controller,
          initialValue: initialValue,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ??
              TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          maxLength: maxLength ?? null,
          decoration: decoration,
          validator: validator,
          cursorColor: Colors.black,
        ),
      );
  InputDecoration get decoration => InputDecoration(
      hintText: hintText??'',
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      labelStyle: CustomStyle.textStyle,
      filled: true,
      fillColor: CustomColor.accent,
      hintStyle: CustomStyle.textStyle,
      focusedBorder: CustomStyle.focusBorder,
      enabledBorder: CustomStyle.focusErrorBorder,
      focusedErrorBorder: CustomStyle.focusErrorBorder,
      errorBorder: CustomStyle.focusErrorBorder,
      prefixIcon: Icon(
        Icons.mail,
        color: CustomColor.primary,
      )
    );
}
