import 'package:flutter_clean_architecture/main/app_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

///appView Model Provider
ChangeNotifierProvider<AppViewModel> appViewModel = ChangeNotifierProvider<AppViewModel>(
      (ref) => AppViewModel(),
);