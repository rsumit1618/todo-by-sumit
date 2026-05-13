import 'package:flutter/material.dart';

class AppAlertDialog {

  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    String buttonText = "OK",
    VoidCallback? onTap,
  }) async {

    await showDialog(
      context: context,

      builder: (_) {
        return AlertDialog(

          title: Text(title),

          content: Text(message),

          actions: [

            TextButton(
              onPressed: () {

                Navigator.pop(context);

                onTap?.call();
              },

              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }
}