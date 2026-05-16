import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/generated/l10n.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page_view_model.dart';
import 'package:kick_stack/ui/app_ui.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/resource.dart';

class SharedRestDetailPageView
    extends BasePageViewWidget<SharedRestPageViewModel> {
  const SharedRestDetailPageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, SharedRestPageViewModel model) {
    final strings = S.of(context);

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.sharedRestDetailTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                strings.sharedRestDetailDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              AppStreamBuilder<Resource<bool>>(
                stream: model.dashboardResponseStream,
                initialData: Resource.none(),
                dataBuilder: (context, response) {
                  final status = response?.status ?? Status.NONE;
                  return AppInfoBanner(
                    message: switch (status) {
                      Status.NONE => strings.restDataNotLoaded,
                      Status.LOADING => strings.loading,
                      Status.SUCCESS => strings.sharedProviderDataAvailable,
                      Status.ERROR =>
                        response?.appError?.error.message ??
                            strings.restDataFailed,
                    },
                    type: switch (status) {
                      Status.NONE => AppInfoBannerType.info,
                      Status.LOADING => AppInfoBannerType.info,
                      Status.SUCCESS => AppInfoBannerType.success,
                      Status.ERROR => AppInfoBannerType.error,
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              AppStreamBuilder<DateTime?>(
                stream: model.lastFetchedAtStream,
                initialData: null,
                dataBuilder: (context, lastFetchedAt) {
                  return Text(
                    lastFetchedAt == null
                        ? strings.noSharedTimestamp
                        : strings.lastFetchedAt(
                            lastFetchedAt.toLocal().toString(),
                          ),
                    style: const TextStyle(color: AppColors.textSecondary),
                  );
                },
              ),
              const Spacer(),
              AppSecondaryButton(
                title: strings.refreshSharedProvider,
                onTap: model.fetchDashboardData,
              ),
              const SizedBox(height: 12),
              AppPrimaryButton(
                title: strings.goBack,
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
