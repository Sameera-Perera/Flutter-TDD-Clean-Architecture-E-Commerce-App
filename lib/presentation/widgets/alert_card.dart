import 'package:flutter/material.dart';

class AlertCard extends StatelessWidget {
  final String image;
  final String? message;
  final Function()? onClick;
  const AlertCard({
    super.key,
    required this.image,
    this.message,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image),
        if (message != null) Text(message!),
        if (onClick != null)
          IconButton(onPressed: onClick, icon: const Icon(Icons.refresh)),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }
}
