import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/generated/l10n.dart';
import 'package:kick_stack/presentation/rest_api_example/rest_api_example_page_view_model.dart';
import 'package:kick_stack/ui/app_ui.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/resource.dart';

class RestApiExamplePageView
    extends BasePageViewWidget<RestApiExamplePageViewModel> {
  const RestApiExamplePageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, RestApiExamplePageViewModel model) {
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
                strings.restApiExampleTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                strings.restApiExampleDescription,
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
                    title: strings.callDashboardSummaryApi,
                    loading: isLoading ?? false,
                    onTap: model.callDashboardSummaryApi,
                  );
                },
              ),
              const SizedBox(height: 24),
              AppStreamBuilder<Resource<bool>>(
                stream: model.dashboardResponseStream,
                initialData: Resource.none(),
                dataBuilder: (context, response) {
                  final status = response?.status ?? Status.NONE;
                  return AppInfoBanner(
                    message: switch (status) {
                      Status.NONE => strings.restApiWaiting,
                      Status.LOADING => strings.loading,
                      Status.SUCCESS => strings.restApiSuccess,
                      Status.ERROR =>
                        response?.appError?.error.message ??
                            strings.restApiFailed,
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
            ],
          ),
        ),
      ),
    );
  }
}
