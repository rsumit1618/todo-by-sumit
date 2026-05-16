import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';

class BaseWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T? model, Widget? child) builder;
  final ProviderBase providerBase;
  final Function(T)? onModelReady;
  final Widget? child;

  const BaseWidget({
    super.key,
    required this.builder,
    required this.providerBase,
    this.onModelReady,
    this.child,
  });

  @override
  _BaseWidget<T> createState() => _BaseWidget<T>();
}

class _BaseWidget<T extends ChangeNotifier> extends State<BaseWidget<T>> {
  T? _model;
  T? _readyModel;
  bool _readyCallbackScheduled = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, child) {
        _model = watch.watch(widget.providerBase as ProviderListenable<T>);
        _scheduleModelReady(_model!);
        return widget.builder(context, _model, child);
      },
      child: widget.child,
    );
  }

  void _scheduleModelReady(T model) {
    if (widget.onModelReady == null || identical(_readyModel, model)) {
      return;
    }

    if (_readyCallbackScheduled) {
      return;
    }

    _readyCallbackScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _readyCallbackScheduled = false;

      final latestModel = _model;
      if (latestModel == null || identical(_readyModel, latestModel)) {
        return;
      }

      _readyModel = latestModel;
      widget.onModelReady?.call(latestModel);
    });
  }
}
