import 'package:flutter/material.dart';
import 'package:tikkeul/constants/enums.dart';
import 'package:tikkeul/globals.dart';

class TikkeulSnackBar {
  late SnackBar _snackBar;

  TikkeulSnackBar.init({
    required String message,
    Color? backgroundColor = Colors.indigo,
  }) {
    _snackBar = SnackBar(
      content: Text(message),
      // action: SnackBarAction(
      //   label: 'Undo',
      //   textColor: Colors.white,
      //   onPressed: () {},
      // ),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: backgroundColor,
    );
  }

  factory TikkeulSnackBar({
    required SnackBarType type,
    required String message,
  }) {
    TikkeulSnackBar snackBar;
    switch (type) {
      case SnackBarType.error:
        snackBar = ErrorSnackBar(message: message);
        break;
      case SnackBarType.success:
        snackBar = SuccessSnackBar(message: message);
        break;
      case SnackBarType.warning:
        snackBar = WarningSnackBar(message: message);
        break;
      default:
        snackBar = TikkeulSnackBar.init(
          message: message,
        );
        break;
    }

    return snackBar;
  }

  SnackBar getSnackBar() {
    return _snackBar;
  }

  showSnackBar() {
    if (snackbarKey.currentState != null) {
      snackbarKey.currentState!.showSnackBar(_snackBar);
    }
  }
}

class ErrorSnackBar extends TikkeulSnackBar {
  ErrorSnackBar({required String message})
      : super.init(message: message, backgroundColor: Colors.redAccent);
}

class SuccessSnackBar extends TikkeulSnackBar {
  SuccessSnackBar({required String message})
      : super.init(message: message, backgroundColor: Colors.blue);
}

class WarningSnackBar extends TikkeulSnackBar {
  WarningSnackBar({required String message})
      : super.init(message: message, backgroundColor: Colors.orange);
}
