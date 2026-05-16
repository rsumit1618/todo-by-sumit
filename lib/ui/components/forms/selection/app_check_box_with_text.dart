import 'package:flutter/material.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/ui/components/forms/selection/app_check_box.dart';

class AppCheckBoxWithText extends StatelessWidget {
  final bool value;
  final String text;
  final ValueChanged<bool>? onChanged;

  const AppCheckBoxWithText({
    super.key,
    required this.value,
    required this.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged == null ? null : () => onChanged?.call(!value),
      borderRadius: BorderRadius.circular(8),
      child: Row(
        children: [
          AppCheckBox(value: value, onChanged: onChanged),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
