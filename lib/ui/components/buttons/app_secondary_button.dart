import 'package:flutter/material.dart';
import 'package:kick_stack/core/theme/app_colors.dart';

class AppSecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double height;
  final double? width;
  final bool loading;
  final Widget? prefixIcon;

  const AppSecondaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.height = 56,
    this.width,
    this.loading = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: loading ? null : onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: AppColors.textPrimary,
        ),
        child: loading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefixIcon != null) ...[
                    prefixIcon!,
                    const SizedBox(width: 10),
                  ],
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
