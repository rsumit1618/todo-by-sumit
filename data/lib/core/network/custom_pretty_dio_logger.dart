import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CustomPrettyDioLogger extends Interceptor {
  final bool request;
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool error;

  final bool compact;
  final int maxWidth;

  static const int _initialTab = 1;
  static const String _tabStep = '    ';

  final void Function(String message) logPrint;
  CustomPrettyDioLogger({
    this.request = true,
    this.requestHeader = false,
    this.requestBody = false,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.compact = true,
    this.maxWidth = 100,
    void Function(String message)? logPrint,
  }) : logPrint = logPrint ?? debugPrint;

  bool get _isRelease => kReleaseMode;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_isRelease) {
      handler.next(options);
      return;
    }

    if (request) _printRequest(options);

    if (requestHeader) {
      _printMap(options.headers, header: 'Headers');
      _printMap(options.queryParameters, header: 'Query');
    }

    if (requestBody && options.method != 'GET') {
      _printData(options.data, header: 'Body');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (_isRelease) {
      handler.next(response);
      return;
    }

    _printResponseHeader(response);

    if (responseHeader) {
      final headers = {
        for (var e in response.headers.map.entries) e.key: e.value.join(','),
      };
      _printMap(headers, header: 'Headers');
    }

    if (responseBody) {
      _printData(response.data, header: 'Response');
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!_isRelease && error) {
      final response = err.response;

      if (response != null) {
        _printBox(
          'ERROR ${response.statusCode} ${response.statusMessage}',
          response.requestOptions.uri.toString(),
        );
        _printData(response.data, header: 'Error Body');
      } else {
        _printBox('ERROR ${err.type.name}', err.message ?? 'Unknown error');
      }
    }

    handler.next(err);
  }

  // ==============================
  // PRINT HELPERS
  // ==============================

  void _printRequest(RequestOptions options) {
    _printBox('REQUEST ${options.method}', options.uri.toString());
  }

  void _printResponseHeader(Response response) {
    _printBox(
      'RESPONSE ${response.requestOptions.method} '
      '${response.statusCode} ${response.statusMessage}',
      response.requestOptions.uri.toString(),
    );
  }

  void _printBox(String title, String msg) {
    logPrint('');
    logPrint('╔╣ $title');
    _printBlock(msg);
    _printLine('╚');
  }

  void _printData(dynamic data, {required String header}) {
    if (data == null) return;

    logPrint('╔ $header');

    if (data is Map) {
      _printPrettyMap(data);
    } else if (data is List) {
      _printPrettyList(data);
    } else {
      _printBlock(data.toString());
    }

    _printLine('╚');
  }

  void _printMap(Map map, {required String header}) {
    if (map.isEmpty) return;
    logPrint('╔ $header');
    map.forEach((key, value) {
      _printBlock('$key : $value');
    });
    _printLine('╚');
  }

  void _printPrettyMap(Map data, {int tabs = _initialTab}) {
    final indent = _indent(tabs);
    logPrint('║$indent{');

    data.forEach((key, value) {
      if (value is Map) {
        logPrint('║${_indent(tabs + 1)}$key:');
        _printPrettyMap(value, tabs: tabs + 2);
      } else if (value is List) {
        logPrint('║${_indent(tabs + 1)}$key: [');
        _printPrettyList(value, tabs: tabs + 2);
        logPrint('║${_indent(tabs + 1)}]');
      } else {
        _printBlock('${_indent(tabs + 1)}$key: $value');
      }
    });

    logPrint('║$indent}');
  }

  void _printPrettyList(List list, {int tabs = _initialTab}) {
    final indent = _indent(tabs);

    for (var item in list) {
      if (item is Map) {
        _printPrettyMap(item, tabs: tabs + 1);
      } else {
        _printBlock('$indent$item');
      }
    }
  }

  void _printBlock(String msg) {
    final lines = (msg.length / maxWidth).ceil();
    for (int i = 0; i < lines; i++) {
      final start = i * maxWidth;
      final end = math.min(start + maxWidth, msg.length);
      logPrint('║ ${msg.substring(start, end)}');
    }
  }

  void _printLine(String prefix) {
    logPrint('$prefix${'═' * maxWidth}');
  }

  String _indent(int tabs) => _tabStep * tabs;
}
