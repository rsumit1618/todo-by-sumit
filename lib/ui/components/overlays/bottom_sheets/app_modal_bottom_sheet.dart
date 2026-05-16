import 'package:flutter/material.dart';
import 'package:kick_stack/core/theme/app_colors.dart';

class AppModalBottomSheet {
  AppModalBottomSheet._();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: child,
        );
      },
    );
  }
}
