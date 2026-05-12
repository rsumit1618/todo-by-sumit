import 'package:flutter_clean_architecture/base/base_page.dart';
import 'package:flutter_clean_architecture/presentation/splash/splash_page_view.dart';
import 'package:flutter_clean_architecture/presentation/splash/splash_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_riverpod/misc.dart';

final splashPageViewModelProvider = ChangeNotifierProvider.autoDispose<SplashPageViewModel>(
  (ref) => SplashPageViewModel(),
);

class SplashPage extends BasePage<SplashPageViewModel>{
  const SplashPage({super.key});

  @override
  SplashPageState createState() =>SplashPageState();
}

class SplashPageState extends BaseStatefulPage<SplashPageViewModel,SplashPage>{

  @override
  void onModelReady(SplashPageViewModel model) {
    model.startLoading();
    super.onModelReady(model);
  }

  @override
  Widget buildView(BuildContext context, SplashPageViewModel model) {
    return SplashPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return splashPageViewModelProvider;
  }
}
