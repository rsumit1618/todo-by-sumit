import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {

  final Widget child;
  final EdgeInsets? padding;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: padding ??
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
          ),
        ],
      ),

      child: child,
    );
  }
}