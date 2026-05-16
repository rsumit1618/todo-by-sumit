import 'package:flutter/material.dart';

class AppBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required Widget child,
    bool isScrollControlled = true,
  }) async {
    await showModalBottomSheet(
      context: context,

      isScrollControlled: isScrollControlled,

      backgroundColor: Colors.transparent,

      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(20),

          decoration: const BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),

          child: child,
        );
      },
    );
  }
}
