import 'dart:async';

import 'package:flutter_clean_architecture/base/base_page_view_model.dart';
import 'package:flutter_clean_architecture/utils/extentions/steam_extension.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';


class SplashPageViewModel extends BasePageViewModel {

  final _gotoDashboardController = StreamController<double>.broadcast();

  Stream<double> get gotoDashboardStream => _gotoDashboardController.stream;

  void startLoading() async {

    for (double i = 0; i <= 1.0; i += 0.1) {
      await Future.delayed(
        const Duration(milliseconds: 250),
      );

      _gotoDashboardController.add(i);
    }
  }

  SplashPageViewModel();

  @override
  void dispose() {
    _gotoDashboardController.close();
    super.dispose();
  }
}