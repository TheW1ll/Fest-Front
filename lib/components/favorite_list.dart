import 'package:festival/components/festival_list_item.dart';
import 'package:festival/models/festival.dart';
import 'package:flutter/material.dart';

class FestivalList extends StatelessWidget {
  const FestivalList({Key? key, required this.favoriteList}) : super(key: key);

  final List<Festival> favoriteList;

  Widget buildListWidget() {
    if (favoriteList.isEmpty) {
      return const Center(
        child: Text("No favorite festivals yet"),
      );
    }

    return ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          final festival = favoriteList[index];
          return FestivalListItem(festival: festival);
        });
  }

  @override
  Widget build(BuildContext context) {
    return buildListWidget();
  }
}
