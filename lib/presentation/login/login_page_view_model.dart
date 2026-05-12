import 'package:domain/usecase/get_user_from_network_usecase.dart';
import 'package:flutter_clean_architecture/base/base_page_view_model.dart';
import 'package:flutter_clean_architecture/utils/enums.dart';
import 'package:flutter_clean_architecture/utils/extentions/steam_extension.dart';
import 'package:flutter_clean_architecture/utils/request_manager.dart';
import 'package:flutter_clean_architecture/utils/resource.dart';
import 'package:rxdart/rxdart.dart';

class LoginPageViewModel extends BasePageViewModel {

  final GetUserFromNetworkUseCase _getUserFromNetworkUseCase;

  // add insurance nickname
  PublishSubject<GetUserFromNetworkUseCaseParam> _login = PublishSubject();

  PublishSubject<Resource<bool>> _loginResponse = PublishSubject();

  Stream<Resource<bool>> get loginResponseStream => _loginResponse.stream;

  LoginPageViewModel(this._getUserFromNetworkUseCase) {

    _login.listen((newValue) {
      RequestManager(newValue, createCall: () => _getUserFromNetworkUseCase.execute(params: newValue))
          .asFlow()
          .listen((event) {
            updateLoader();
        _loginResponse.safeAdd(event);
        if (event.status == Status.ERROR) {
          showToastWithError(event.appError!);
        }
      });
    });
  }
}