import 'package:flutter/material.dart';

class AppListView extends StatelessWidget {

  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const AppListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: itemCount,

      padding: const EdgeInsets.all(16),

      separatorBuilder: (_, __) =>
      const SizedBox(height: 14),

      itemBuilder: itemBuilder,
    );
  }
}