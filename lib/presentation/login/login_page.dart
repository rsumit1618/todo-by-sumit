import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_page.dart';
import 'package:flutter_clean_architecture/di/view_model_provider/login/login_provider.dart';
import 'package:flutter_clean_architecture/presentation/login/login_page_view.dart';
import 'package:flutter_clean_architecture/presentation/login/login_page_view_model.dart';
import 'package:flutter_riverpod/misc.dart';

class LoginPage extends BasePage<LoginPageViewModel>{
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BaseStatefulPage<LoginPageViewModel,LoginPage>{
  @override
  Widget buildView(BuildContext context, LoginPageViewModel model) {
    return LoginPageView(provideBase());
  }

  @override
  ProviderBase provideBase() {
    return loginViewModelProvider;
  }
}