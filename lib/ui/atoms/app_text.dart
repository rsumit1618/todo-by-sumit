import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_colors.dart';

class AppText extends StatelessWidget {

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign? textAlign;
  final int? maxLines;

  const AppText(
      this.text, {
        super.key,
        this.fontSize = 14,
        this.fontWeight = FontWeight.w400,
        this.color = AppColors.textPrimary,
        this.textAlign,
        this.maxLines,
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: maxLines != null
          ? TextOverflow.ellipsis
          : null,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}