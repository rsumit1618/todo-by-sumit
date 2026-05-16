import 'package:flutter/services.dart';

class AppTextInputFormatter {
  final TextInputFormatter inputFormatter;
  final RegExp validationRegex;

  const AppTextInputFormatter({
    required this.inputFormatter,
    required this.validationRegex,
  });

  bool validate(String value) => validationRegex.hasMatch(value);

  static final textOnly = AppTextInputFormatter(
    inputFormatter: FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
    validationRegex: RegExp(r'^[a-zA-Z ]+$'),
  );

  static final email = AppTextInputFormatter(
    inputFormatter: FilteringTextInputFormatter.allow(
      RegExp(r"[a-zA-Z0-9!#%&'*+\-/=?^_`{|}~;.@]"),
    ),
    validationRegex: RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  );

  static final digitsOnly = AppTextInputFormatter(
    inputFormatter: FilteringTextInputFormatter.digitsOnly,
    validationRegex: RegExp(r'^[0-9]+$'),
  );

  static final decimalAmount = AppTextInputFormatter(
    inputFormatter: FilteringTextInputFormatter.allow(
      RegExp(r'^\d+\.?\d{0,2}'),
    ),
    validationRegex: RegExp(r'^\d+(\.\d{1,2})?$'),
  );
}
