import 'package:pulse/helpers/app_export.dart';

//Popup Message
void showMsg(
  BuildContext context,
  Msg, {
  VoidCallback? onpress,
  VoidCallback? oncancel,
  bool showCancle = false,
  bool disablePopCancle = false,
  bool disablePopOk = false,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      surfaceTintColor: Colors.white,
      title: Text(Msg, style: TextStyle(color: Colors.black, fontSize: 15)),
      actions: <Widget>[
        if (showCancle)
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              if (!disablePopCancle) {
                Navigator.of(context).pop();
              }
              if (oncancel != null) {
                oncancel();
              }
            },
          ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          child: Text(
            'Ok',
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          onPressed: () {
            if (!disablePopOk) {
              Navigator.of(context).pop();
            }
            if (onpress != null) {
              onpress();
            }
          },
        ),
      ],
    ),
  );
}


// Validation Function
/// Checks if string is email.
bool isValidEmail(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Password should have,
/// at least a upper case letter
///  at least a lower case letter
///  at least a digit
///  at least a special character [@#$%^&+=]
///  length of at least 4
/// no white space allowed

bool isValidPassword(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null || inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^(?=.*[A-Z])(?=.*[@#$&\-_0-9])[A-Za-z@#$&\-_0-9]{8,24}$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string consist only Alphabet. (No Whitespace)
bool isText(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^[a-z A-Z]+$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

/// Checks if string is phone number
bool isValidPhone(
  String? inputString, {
  bool isRequired = false,
}) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    if (inputString.length > 16 || inputString.length < 6) return false;

    const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool isNumber(String? input) {
  if (input == null) {
    return false;
  }

  // Use a try-catch block to attempt to parse the input as a number
  try {
    double.parse(input);
    return true;
  } catch (e) {
    return false;
  }
}

bool isValidDateTime(
  DateTime? inputDateTime, {
  bool isRequired = false,
}) {
  bool isInputDateTimeValid = false;

  if (!isRequired && inputDateTime == null) {
    return true;
  }

  if (inputDateTime != null) {
    // No need to parse, we already have a DateTime object
    isInputDateTimeValid = true;
  }

  return isInputDateTimeValid;
}