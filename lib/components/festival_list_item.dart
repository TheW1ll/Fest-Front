import 'package:flutter/material.dart';
import 'package:festival/models/festival.dart';

class FestivalListItem extends StatelessWidget {
  const FestivalListItem({super.key, required this.festival});

  final Festival festival;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(festival.getName()),
      subtitle: Text("${festival.getCity()} • ${festival.getMajorField()}"),
    );
  }
}
