import 'package:domain/entities/live_update_entity.dart';
import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/generated/l10n.dart';
import 'package:kick_stack/presentation/websocket_example/websocket_example_page_view_model.dart';
import 'package:kick_stack/ui/app_ui.dart';
import 'package:kick_stack/utils/enums.dart';
import 'package:kick_stack/utils/resource.dart';

class WebSocketExamplePageView
    extends BasePageViewWidget<WebSocketExamplePageViewModel> {
  const WebSocketExamplePageView(super.providerBase, {super.key});

  @override
  Widget build(BuildContext context, WebSocketExamplePageViewModel model) {
    final strings = S.of(context);
    model.start(
      seedTitles: [
        strings.liveSeedOrderCreated,
        strings.liveSeedPaymentReceived,
        strings.liveSeedInventoryUpdated,
      ],
    );

    return ColoredBox(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                strings.webSocketExampleTitle,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                strings.webSocketExampleDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              AppStreamBuilder<Resource<bool>>(
                stream: model.connectionStateStream,
                initialData: Resource.none(),
                dataBuilder: (context, response) {
                  final status = response?.status ?? Status.NONE;
                  return AppInfoBanner(
                    message: switch (status) {
                      Status.NONE => strings.webSocketDisconnected,
                      Status.LOADING => strings.webSocketConnecting,
                      Status.SUCCESS => strings.webSocketConnected,
                      Status.ERROR => strings.webSocketFallback,
                    },
                    type: switch (status) {
                      Status.SUCCESS => AppInfoBannerType.success,
                      Status.ERROR => AppInfoBannerType.info,
                      _ => AppInfoBannerType.info,
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: AppStreamBuilder<List<LiveUpdateEntity>>(
                  stream: model.itemsStream,
                  initialData: const [],
                  dataBuilder: (context, items) {
                    final liveItems = items ?? [];
                    if (liveItems.isEmpty) {
                      return Center(child: Text(strings.loading));
                    }

                    return ListView.separated(
                      itemCount: liveItems.length,
                      separatorBuilder: (_, __) => const Divider(
                        color: AppColors.divider,
                      ),
                      itemBuilder: (context, index) {
                        final item = liveItems[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            item.title,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                            ),
                          ),
                          subtitle: Text(
                            strings.lastFetchedAt(
                              item.updatedAt.toLocal().toString(),
                            ),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          trailing: IconButton(
                            tooltip: strings.deleteLiveItem,
                            onPressed: () => model.deleteItem(item.id),
                            icon: const Icon(Icons.delete_outline),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
