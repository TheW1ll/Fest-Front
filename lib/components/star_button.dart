import 'package:flutter/material.dart';

class StarButton extends StatelessWidget {
  const StarButton(
      {Key? key, required this.isFavorite, required this.onButtonClicked})
      : super(key: key);

  final bool isFavorite;
  final void Function() onButtonClicked;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onButtonClicked,
        icon: isFavorite
            ? const Icon(
          Icons.star,
          color: Colors.amberAccent,
        )
            : const Icon(Icons.star_border, color: Colors.amberAccent));
  }
}