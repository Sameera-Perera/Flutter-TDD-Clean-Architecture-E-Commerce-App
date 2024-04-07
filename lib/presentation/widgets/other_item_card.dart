import 'package:flutter/material.dart';

class OtherItemCard extends StatelessWidget {
  final String title;
  final Function()? onClick;
  const OtherItemCard({
    Key? key,
    required this.title,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 4,
        top: 2
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onClick,
        child: Ink(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border.all(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
