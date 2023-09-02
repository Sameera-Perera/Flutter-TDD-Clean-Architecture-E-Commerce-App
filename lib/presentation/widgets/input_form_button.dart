import 'package:flutter/material.dart';

class InputFormButton extends StatelessWidget {
  final Function() onClick;
  final String titleText;
  final Color? color;

  const InputFormButton({
    Key? key,
    required this.onClick,
    required this.titleText,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(horizontal: 16)),
        maximumSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        minimumSize:
            MaterialStateProperty.all<Size>(const Size(double.maxFinite, 50)),
        backgroundColor:
            MaterialStateProperty.all<Color>(color??Theme.of(context).primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
      ),
      child: Text(
        titleText,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
