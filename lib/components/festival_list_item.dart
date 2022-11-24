import 'package:flutter/material.dart';
import 'package:festival/models/festival.dart';
import 'package:go_router/go_router.dart';

class FestivalListItem extends StatelessWidget {
  const FestivalListItem({super.key, required this.festival});

  final Festival festival;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed("details", params: {'uid': festival.id});
      },
      child: ListTile(
        title: Text(festival.getName()),
        subtitle: Text("${festival.getCity()} • ${festival.getMajorField()}"),
      ),
    );
  }
}
