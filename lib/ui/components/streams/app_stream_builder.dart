import 'dart:async';

import 'package:flutter/material.dart';

/// A [StreamBuilder] alternative that provides builder and event callbacks.
class AppStreamBuilder<T> extends StreamBuilderBase<T, AsyncSnapshot<T>> {
  final Stream<T> stream;

  final ValueChanged<T>? onData;

  final ValueChanged<Object>? onError;

  final VoidCallback? onDone;

  final T? initialData;

  final WidgetBuilder? busyBuilder;

  final Widget Function(BuildContext context, T? data) dataBuilder;

  final Widget Function(BuildContext context, Object? error)? errorBuilder;

  const AppStreamBuilder({
    super.key,
    required this.stream,
    this.onData,
    this.onError,
    this.onDone,
    this.initialData,
    this.busyBuilder,
    required this.dataBuilder,
    this.errorBuilder,
  }) : super(stream: stream);

  @override
  AsyncSnapshot<T> initial() {
    return AsyncSnapshot<T>.withData(ConnectionState.none, initialData as T);
  }

  @override
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) {
    return current.inState(ConnectionState.waiting);
  }

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    try {
      onData?.call(data);

      return AsyncSnapshot<T>.withData(ConnectionState.active, data);
    } catch (error) {
      return AsyncSnapshot<T>.withError(ConnectionState.active, error);
    }
  }

  @override
  AsyncSnapshot<T> afterError(
    AsyncSnapshot<T> current,
    Object error,
    StackTrace stackTrace,
  ) {
    onError?.call(error);
    return AsyncSnapshot<T>.withError(
      ConnectionState.active,
      error,
      stackTrace,
    );
  }

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) {
    onDone?.call();

    return current.inState(ConnectionState.done);
  }

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) {
    return current.inState(ConnectionState.none);
  }

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return _handleBusy(context);

      case ConnectionState.active:
      case ConnectionState.done:
        return _handleSnapshot(context, snapshot);

      case ConnectionState.none:
        return const SizedBox.shrink();
    }
  }

  Widget _handleBusy(BuildContext context) {
    if (initialData != null) {
      return _handleData(context, initialData);
    }

    return busyBuilder?.call(context) ?? const SizedBox.shrink();
  }

  Widget _handleData(BuildContext context, T? data) {
    try {
      return dataBuilder(context, data);
    } catch (error) {
      return _handleError(context, error);
    }
  }

  Widget _handleSnapshot(BuildContext context, AsyncSnapshot<T> snapshot) {
    if (snapshot.hasError) {
      return _handleError(context, snapshot.error);
    }

    return _handleData(context, snapshot.data);
  }

  Widget _handleError(BuildContext context, Object? error) {
    return errorBuilder?.call(context, error) ?? const SizedBox.shrink();
  }
}
