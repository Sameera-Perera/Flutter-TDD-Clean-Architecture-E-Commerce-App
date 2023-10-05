import 'package:flutter/material.dart';

class FavoriteIconButton extends StatelessWidget {
  const FavoriteIconButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black87,
          shape: const CircleBorder(),
          elevation: 0,
          padding: const EdgeInsets.all(4),
        ),
        child: const Icon(
          Icons.favorite_border,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}
