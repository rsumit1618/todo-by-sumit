import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/di/view_model_provider/websocket_example/websocket_example_provider.dart';
import 'package:kick_stack/presentation/websocket_example/websocket_example_page_view.dart';
import 'package:kick_stack/presentation/websocket_example/websocket_example_page_view_model.dart';

class WebSocketExamplePage extends BasePage<WebSocketExamplePageViewModel> {
  const WebSocketExamplePage({super.key});

  @override
  WebSocketExamplePageState createState() => WebSocketExamplePageState();
}

class WebSocketExamplePageState
    extends
        BaseStatefulPage<WebSocketExamplePageViewModel, WebSocketExamplePage> {
  @override
  Widget buildView(BuildContext context, WebSocketExamplePageViewModel model) {
    return WebSocketExamplePageView(provideBase());
  }

  @override
  ProviderBase<dynamic> provideBase() {
    return webSocketExampleViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => AppColors.background;

  @override
  Color statusBarColor() => AppColors.background;
}
