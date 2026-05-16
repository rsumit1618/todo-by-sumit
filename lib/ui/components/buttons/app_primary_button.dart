import 'package:flutter/material.dart';
import 'package:kick_stack/core/theme/app_colors.dart';

class AppPrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double height;
  final double? width;
  final bool loading;
  final Widget? prefixIcon;

  const AppPrimaryButton({
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

      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),

          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
          ),
        ),

        child: ElevatedButton(
          onPressed: loading ? null : onTap,

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),

          child: loading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
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
                        color: AppColors.onPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
