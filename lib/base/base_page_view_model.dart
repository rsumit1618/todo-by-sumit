import 'package:domain/constant/error_info.dart';
import 'package:domain/errors/app_error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/base/base_view_model.dart';
import 'package:flutter_clean_architecture/utils/extentions/steam_extension.dart';
import 'package:rxdart/rxdart.dart';

class BasePageViewModel extends BaseViewModel {

  final PublishSubject<AppError> _error = PublishSubject<AppError>();
  final PublishSubject<String> _toast = PublishSubject<String>();

  final PublishSubject<SuccessToastData> _successSubject = PublishSubject<SuccessToastData>();
  Stream<SuccessToastData> get successStream => _successSubject.stream;

  final PublishSubject<StringError> _errorStringReq = PublishSubject<StringError>();
  Stream<StringError> get errorStringStream => _errorStringReq.stream;

  bool _isLoading = false;

  final PublishSubject<bool> _loading = PublishSubject();

  Stream<bool> get loadingStream => _loading.stream;

  BasePageViewModel();

  void updateLoader() {
    if (!_isLoading) {
      _isLoading = true;
      _loading.safeAdd(true);
    } else {
      _isLoading = false;
      _loading.safeAdd(false);
    }
  }

  void showToastWithError(AppError error) {
    try {
      _error.safeSinkAdd(error);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showSuccessToast(SuccessToastData success) {
    _successSubject.safeSinkAdd(success);
  }

  void showToastWithString(String message) {
    _toast.safeSinkAdd(message);
  }

  void showStringError(String message, {ErrorColor errorColor = ErrorColor.red}) {
    _errorStringReq.safeSinkAdd(StringError(message: message, errorColor: errorColor));
  }

  @override
  void dispose() {
    _error.close();
    _toast.close();
    super.dispose();
  }
}


class SuccessToastData {
  final String title;
  final String desc;

  SuccessToastData({this.title = '', this.desc = ''});
}

class StringError{
  final String message;
  final ErrorColor errorColor;

  StringError({required this.message, required this.errorColor});
}