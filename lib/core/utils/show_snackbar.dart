import 'package:flutter/material.dart';

class CustomSnackBar {
  static void showSuccessSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.green);
  }

  static void showInfoSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.blue);
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message, Colors.red);
  }

  static void _showSnackBar(BuildContext context, String message, Color color) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        showCloseIcon: true,
        closeIconColor: Colors.white,
        dismissDirection: DismissDirection.horizontal,
        content: Text(
          message,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
        ),
        backgroundColor: color,
      ));
    });
  }
}
