import 'package:eshop/core/constant/images.dart';
import 'package:flutter/material.dart';

class InputFormButton extends StatelessWidget {
  final Function() onClick;
  final String? titleText;
  final Icon? icon;
  final Color? color;
  final double? cornerRadius;
  final EdgeInsets padding;

  const InputFormButton(
      {Key? key,
      required this.onClick,
      this.titleText,
      this.icon,
      this.color,
      this.cornerRadius,
      this.padding = const EdgeInsets.symmetric(horizontal: 16)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(padding),
        maximumSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        backgroundColor: MaterialStateProperty.all<Color>(
            color ?? Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(cornerRadius ?? 12.0)),
        ),
      ),
      child: titleText != null
          ? Text(
              titleText!,
              style: const TextStyle(color: Colors.white),
            )
          : Image.asset(
              kFilterIcon,
              color: Colors.white,
            ),
    );
  }
}
