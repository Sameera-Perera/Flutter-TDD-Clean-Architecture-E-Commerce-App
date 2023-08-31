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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          color: Colors.white,
          elevation: 1,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25),
            child: Row(
              children: [
                Text(title,
                  style: Theme.of(context).textTheme.titleSmall,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}