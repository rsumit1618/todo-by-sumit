import 'package:flutter/material.dart';
import 'package:kick_stack/ui/components/forms/textfields/app_text_field.dart';

class AppDropdownField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String? hint;
  final VoidCallback onTap;

  const AppDropdownField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      label: label,
      hint: hint,
      readOnly: true,
      onTap: onTap,
      suffixIcon: IconButton(
        onPressed: onTap,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
      ),
    );
  }
}
