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
    switch (type) {
      case SnackBarType.error:
        return ErrorSnackBar(message: message);
    }
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
