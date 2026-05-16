import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/generated/l10n.dart';
import 'package:kick_stack/main/navigation/route_path.dart';
import 'package:kick_stack/presentation/splash/splash_page_view_model.dart';
import 'package:kick_stack/ui/app_ui.dart';

class SplashPageView extends BasePageViewWidget<SplashPageViewModel> {
  const SplashPageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, SplashPageViewModel model) {
    final strings = S.of(context);

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  strings.appName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  strings.starterSubtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                AppPrimaryButton(
                  title: strings.openRestApiExample,
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.restApiExample);
                  },
                ),
                const SizedBox(height: 12),
                AppSecondaryButton(
                  title: strings.openSqliteExample,
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.sqliteExample);
                  },
                ),
                const SizedBox(height: 12),
                AppSecondaryButton(
                  title: strings.openSharedProviderExample,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.sharedProviderExample,
                    );
                  },
                ),
                const SizedBox(height: 12),
                AppSecondaryButton(
                  title: strings.openWebSocketExample,
                  onTap: () {
                    Navigator.pushNamed(context, RoutePaths.webSocketExample);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
