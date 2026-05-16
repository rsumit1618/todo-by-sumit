import 'package:domain/constant/error_info.dart';
import 'package:domain/errors/app_error.dart';
import 'package:flutter/material.dart';
import 'package:kick_stack/base/base_view_model.dart';
import 'package:kick_stack/utils/extentions/steam_extension.dart';
import 'package:rxdart/rxdart.dart';

class BasePageViewModel extends BaseViewModel {
  final PublishSubject<AppError> _error = PublishSubject<AppError>();
  final PublishSubject<String> _toast = PublishSubject<String>();
  final PublishSubject<UiEvent> _uiEvent = PublishSubject<UiEvent>();

  Stream<UiEvent> get uiEventStream => _uiEvent.stream;

  final PublishSubject<SuccessToastData> _successSubject =
      PublishSubject<SuccessToastData>();
  Stream<SuccessToastData> get successStream => _successSubject.stream;

  final PublishSubject<StringError> _errorStringReq =
      PublishSubject<StringError>();
  Stream<StringError> get errorStringStream => _errorStringReq.stream;

  int _loadingRequestCount = 0;

  final BehaviorSubject<bool> _loading = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get loadingStream => _loading.stream;

  bool get isLoading => _loading.value;

  BasePageViewModel();

  void setLoading(bool value) {
    if (value) {
      showLoader();
    } else {
      hideLoader();
    }
  }

  void showLoader() {
    _loadingRequestCount++;
    _emitLoading();
  }

  void hideLoader() {
    if (_loadingRequestCount > 0) {
      _loadingRequestCount--;
    }
    _emitLoading();
  }

  void handleLoading(bool value) {
    setLoading(value);
  }

  /// Backward-compatible API for older view models.
  /// Prefer `setLoading`, `showLoader`, or `hideLoader` in new code.
  void updateLoader() {
    setLoading(!isLoading);
  }

  void _emitLoading() {
    final next = _loadingRequestCount > 0;
    if (_loading.value != next) {
      _loading.safeAdd(next);
    }
  }

  void showToastWithError(AppError error) {
    try {
      _error.safeSinkAdd(error);
      _uiEvent.safeSinkAdd(UiEvent.error(error));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showSuccessToast(SuccessToastData success) {
    _successSubject.safeSinkAdd(success);
    _uiEvent.safeSinkAdd(UiEvent.success(success));
  }

  void showToastWithString(String message) {
    _toast.safeSinkAdd(message);
    _uiEvent.safeSinkAdd(UiEvent.toast(message));
  }

  void showStringError(
    String message, {
    ErrorColor errorColor = ErrorColor.red,
  }) {
    final error = StringError(message: message, errorColor: errorColor);
    _errorStringReq.safeSinkAdd(error);
    _uiEvent.safeSinkAdd(UiEvent.stringError(error));
  }

  @override
  void dispose() {
    _error.close();
    _toast.close();
    _uiEvent.close();
    _successSubject.close();
    _errorStringReq.close();
    _loading.close();
    super.dispose();
  }
}

enum UiEventType { error, toast, success, stringError }

class UiEvent {
  final UiEventType type;
  final AppError? error;
  final String? message;
  final SuccessToastData? success;
  final StringError? stringError;

  const UiEvent._({
    required this.type,
    this.error,
    this.message,
    this.success,
    this.stringError,
  });

  factory UiEvent.error(AppError error) {
    return UiEvent._(type: UiEventType.error, error: error);
  }

  factory UiEvent.toast(String message) {
    return UiEvent._(type: UiEventType.toast, message: message);
  }

  factory UiEvent.success(SuccessToastData success) {
    return UiEvent._(type: UiEventType.success, success: success);
  }

  factory UiEvent.stringError(StringError error) {
    return UiEvent._(type: UiEventType.stringError, stringError: error);
  }
}

class SuccessToastData {
  final String title;
  final String desc;

  SuccessToastData({this.title = '', this.desc = ''});
}

class StringError {
  final String message;
  final ErrorColor errorColor;

  StringError({required this.message, required this.errorColor});
}
