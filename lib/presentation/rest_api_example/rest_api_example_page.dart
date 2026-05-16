import 'package:flutter/material.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/di/view_model_provider/rest_api_example/rest_api_example_provider.dart';
import 'package:kick_stack/presentation/rest_api_example/rest_api_example_page_view.dart';
import 'package:kick_stack/presentation/rest_api_example/rest_api_example_page_view_model.dart';

class RestApiExamplePage extends BasePage<RestApiExamplePageViewModel> {
  const RestApiExamplePage({super.key});

  @override
  RestApiExamplePageState createState() => RestApiExamplePageState();
}

class RestApiExamplePageState
    extends
        BaseStatefulPage<RestApiExamplePageViewModel, RestApiExamplePage> {
  @override
  Widget buildView(BuildContext context, RestApiExamplePageViewModel model) {
    return RestApiExamplePageView(provideBase());
  }

  @override
  ProviderBase<dynamic> provideBase() {
    return restApiExampleViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => AppColors.background;

  @override
  Color statusBarColor() => AppColors.background;
}
