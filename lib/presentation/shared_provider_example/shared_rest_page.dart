import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/di/view_model_provider/shared_provider_example/shared_rest_provider.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page_view.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page_view_model.dart';
import 'package:flutter_riverpod/misc.dart';

class SharedRestPage extends BasePage<SharedRestPageViewModel> {
  const SharedRestPage({super.key});

  @override
  SharedRestPageState createState() => SharedRestPageState();
}

class SharedRestPageState
    extends BaseStatefulPage<SharedRestPageViewModel, SharedRestPage> {
  @override
  void onModelReady(SharedRestPageViewModel model) {
    model.fetchDashboardData();
  }

  @override
  Widget buildView(BuildContext context, SharedRestPageViewModel model) {
    return SharedRestPageView(provideBase());
  }

  @override
  ProviderBase<dynamic> provideBase() {
    return sharedRestViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => AppColors.background;

  @override
  Color statusBarColor() => AppColors.background;
}
