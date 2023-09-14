import 'package:flutter/material.dart';

class OutlineLabelCard extends StatelessWidget {
  final String title;
  final Widget child;
  const OutlineLabelCard({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        labelText: title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: child,
    );
  }
}
