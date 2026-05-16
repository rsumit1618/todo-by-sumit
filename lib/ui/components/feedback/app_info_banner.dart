import 'package:flutter/material.dart';
import 'package:kick_stack/core/theme/app_colors.dart';

enum AppInfoBannerType { info, success, warning, error }

class AppInfoBanner extends StatelessWidget {
  final String message;
  final AppInfoBannerType type;
  final IconData? icon;

  const AppInfoBanner({
    super.key,
    required this.message,
    this.type = AppInfoBannerType.info,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      AppInfoBannerType.info => AppColors.info,
      AppInfoBannerType.success => AppColors.success,
      AppInfoBannerType.warning => AppColors.warning,
      AppInfoBannerType.error => AppColors.error,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color.withOpacity(0.25)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon ?? Icons.info_outline, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: color, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
