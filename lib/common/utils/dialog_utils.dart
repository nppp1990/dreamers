import 'package:adaptive_dialog/adaptive_dialog.dart';
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

  static Future showLoading(BuildContext context, {String? text, VoidCallback? dismissCallback}) async {
    return await showDialog(
        useSafeArea: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
  }

  static Future<bool> showConfirmationDialog(
    BuildContext context,
    String? title,
    String? message, {
    String okLabel = 'OK',
    String cancelLabel = 'Cancel',
  }) async {
    final res = await showOkCancelAlertDialog(
      context: context,
      title: title,
      message: message,
      okLabel: okLabel,
      cancelLabel: cancelLabel,
    );
    return res == OkCancelResult.ok;
  }
}
