import 'package:flutter/material.dart';

final class DialogUtils {
  DialogUtils._();

  static void showToast(BuildContext context, String message, {Duration duration = const Duration(seconds: 1)}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Text(message),
      duration: duration,
    ));
  }

  static void showLoading(BuildContext context, String text, {VoidCallback? dismissCallback}) {
  }
}
