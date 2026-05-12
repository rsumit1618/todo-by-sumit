import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_view_model.dart';

GlobalKey<NavigatorState> appLevelKey = GlobalKey(debugLabel: 'app-key');

class AppViewModel extends BaseViewModel {
  AppViewModel();
}