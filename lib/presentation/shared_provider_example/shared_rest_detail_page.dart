import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/di/view_model_provider/shared_provider_example/shared_rest_provider.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_detail_page_view.dart';
import 'package:kick_stack/presentation/shared_provider_example/shared_rest_page_view_model.dart';
import 'package:flutter_riverpod/misc.dart';

class SharedRestDetailPage extends BasePage<SharedRestPageViewModel> {
  const SharedRestDetailPage({super.key});

  @override
  SharedRestDetailPageState createState() => SharedRestDetailPageState();
}

class SharedRestDetailPageState
    extends BaseStatefulPage<SharedRestPageViewModel, SharedRestDetailPage> {
  @override
  Widget buildView(BuildContext context, SharedRestPageViewModel model) {
    return SharedRestDetailPageView(provideBase());
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
