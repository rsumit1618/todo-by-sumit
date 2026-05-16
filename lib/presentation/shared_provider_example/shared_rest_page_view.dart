import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/generated/l10n.dart';
import 'package:kick_stack/main/navigation/route_path.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page_view_model.dart';
import 'package:kick_stack/ui/app_ui.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/resource.dart';

class SharedRestPageView extends BasePageViewWidget<SharedRestPageViewModel> {
  const SharedRestPageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, SharedRestPageViewModel model) {
    final strings = S.of(context);

    return AppKeyboardHide(
      child: ColoredBox(
        color: AppColors.background,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  strings.sharedRestTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  strings.sharedRestDescription,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                AppStreamBuilder<bool>(
                  stream: model.loadingStream,
                  initialData: false,
                  dataBuilder: (context, isLoading) {
                    return AppPrimaryButton(
                      title: strings.fetchRestData,
                      loading: isLoading ?? false,
                      onTap: model.fetchDashboardData,
                    );
                  },
                ),
                const SizedBox(height: 12),
                AppSecondaryButton(
                  title: strings.openSharedDetails,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      RoutePaths.sharedProviderDetail,
                    );
                  },
                ),
                const SizedBox(height: 24),
                AppStreamBuilder<Resource<bool>>(
                  stream: model.dashboardResponseStream,
                  initialData: Resource.none(),
                  dataBuilder: (context, response) {
                    return _SharedRestStatusCard(response: response);
                  },
                ),
                const SizedBox(height: 16),
                AppStreamBuilder<DateTime?>(
                  stream: model.lastFetchedAtStream,
                  initialData: null,
                  dataBuilder: (context, lastFetchedAt) {
                    if (lastFetchedAt == null) {
                      return const SizedBox.shrink();
                    }

                    return AppInfoBanner(
                      message: strings.lastFetchedAt(
                        lastFetchedAt.toLocal().toString(),
                      ),
                      type: AppInfoBannerType.info,
                    );
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

class _SharedRestStatusCard extends StatelessWidget {
  final Resource<bool>? response;

  const _SharedRestStatusCard({required this.response});

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final status = response?.status ?? Status.NONE;

    return AppInfoBanner(
      message: switch (status) {
        Status.NONE => strings.restDataNotLoaded,
        Status.LOADING => strings.loading,
        Status.SUCCESS => strings.restDataLoaded,
        Status.ERROR =>
          response?.appError?.error.message ?? strings.restDataFailed,
      },
      type: switch (status) {
        Status.NONE => AppInfoBannerType.info,
        Status.LOADING => AppInfoBannerType.info,
        Status.SUCCESS => AppInfoBannerType.success,
        Status.ERROR => AppInfoBannerType.error,
      },
    );
  }
}
