import 'package:flutter_clean_architecture/di/usecase_provider/usecase_provider.dart';
import 'package:flutter_clean_architecture/presentation/login/login_page_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

///login view model provider
final loginViewModelProvider = ChangeNotifierProvider.autoDispose<LoginPageViewModel>(
      (ref) => LoginPageViewModel(ref.read(getUserFromNetworkUseCaseProvider)));
