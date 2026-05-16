import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_page.dart';
import 'package:kick_stack/core/theme/app_colors.dart';
import 'package:kick_stack/di/view_model_provider/sqlite_example/task_home_provider.dart';
import 'package:kick_stack/presentation/sqlite_example/task_home_page_view.dart';
import 'package:kick_stack/presentation/sqlite_example/task_home_page_view_model.dart';
import 'package:flutter_riverpod/misc.dart';

class TaskHomePage extends BasePage<TaskHomePageViewModel> {
  const TaskHomePage({super.key});

  @override
  TaskHomePageState createState() => TaskHomePageState();
}

class TaskHomePageState
    extends BaseStatefulPage<TaskHomePageViewModel, TaskHomePage> {
  @override
  void onModelReady(TaskHomePageViewModel model) {
    model.load();
  }

  @override
  Widget buildView(BuildContext context, TaskHomePageViewModel model) {
    return TaskHomePageView(provideBase());
  }

  @override
  ProviderBase<dynamic> provideBase() {
    return taskHomeViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => AppColors.background;

  @override
  Color statusBarColor() => AppColors.background;
}
