import 'package:flutter/material.dart';
import 'package:kick_stack/core/theme/app_colors.dart';

class AppCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  const AppCheckBox({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      activeColor: AppColors.primary,
      side: const BorderSide(color: AppColors.border, width: 1.4),
      onChanged: onChanged == null
          ? null
          : (selected) => onChanged?.call(selected ?? false),
    );
  }
}
