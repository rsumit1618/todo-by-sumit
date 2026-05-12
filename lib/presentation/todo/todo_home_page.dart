import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_page.dart';
import 'package:flutter_clean_architecture/di/view_model_provider/todo/todo_home_provider.dart';
import 'package:flutter_clean_architecture/presentation/todo/todo_home_page_view.dart';
import 'package:flutter_clean_architecture/presentation/todo/todo_home_page_view_model.dart';
import 'package:flutter_riverpod/misc.dart';

class TodoHomePage extends BasePage<TodoHomePageViewModel> {
  const TodoHomePage({super.key});

  @override
  TodoHomePageState createState() => TodoHomePageState();
}

class TodoHomePageState
    extends BaseStatefulPage<TodoHomePageViewModel, TodoHomePage> {
  @override
  void onModelReady(TodoHomePageViewModel model) {
    model.load();
  }

  @override
  Widget buildView(BuildContext context, TodoHomePageViewModel model) {
    return TodoHomePageView(provideBase());
  }

  @override
  ProviderBase<dynamic> provideBase() {
    return todoHomeViewModelProvider;
  }

  @override
  Color scaffoldBackgroundColor() => Colors.white;

  @override
  Color statusBarColor() => Colors.white;
}
