import 'package:eshop/core/constant/images.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class InputFormButton extends StatelessWidget {
  final Function() onClick;
  final String? titleText;
  final Icon? icon;
  final Color? color;
  final double? cornerRadius;
  final EdgeInsets padding;

  const InputFormButton({
    super.key,
    required this.onClick,
    this.titleText,
    this.icon,
    this.color,
    this.cornerRadius,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: WidgetStateProperty.all<EdgeInsets>(padding),
        maximumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 28.sp)),
        minimumSize: WidgetStateProperty.all<Size>(Size(double.maxFinite, 28.sp)),
        backgroundColor: WidgetStateProperty.all<Color>(
          color ?? colorScheme.primary,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(
          colorScheme.onPrimary,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 12.0),
          ),
        ),
      ),
      child: titleText != null
          ? Text(
              titleText!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimary,
                  ),
            )
          : Image.asset(
              kFilterIcon,
              color: colorScheme.onPrimary,
              height: 22.sp,
              width: 22.sp,
            ),
    );
  }
}