import 'package:festival/components/star_button.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/services/user.service.dart';
import 'package:go_router/go_router.dart';

class FestivalListItem extends StatefulWidget {
  const FestivalListItem({Key? key, required this.festival}) : super(key: key);

  @override
  State<FestivalListItem> createState() => _FestivalListItemState();

  final Festival festival;
}

class _FestivalListItemState extends State<FestivalListItem> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = _isFavoriteOfCurrentUser();
    super.initState();
  }

  bool _isFavoriteOfCurrentUser() {
    final localUser = UserService().getLocalUser();

    if (localUser == null) {
      return false;
    }

    return localUser.favoriteFestivals.contains(widget.festival.id);
  }

  void _onStarButtonClicked() {
    setState(() {
      if (_isFavoriteOfCurrentUser()) {
        isFavorite = false;
        UserService().removeFestivalFromFavorites(widget.festival.id);
      } else {
        isFavorite = true;
        UserService().addFestivalToFavorites(widget.festival.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.goNamed("details", params: {'uid': widget.festival.id});
      },
      child: ListTile(
        title: Text(widget.festival.getName()),
        subtitle: Text(
            "${widget.festival.getCity()} • ${widget.festival.getMajorField()}"),
        trailing: StarButton(
            isFavorite: isFavorite, onButtonClicked: _onStarButtonClicked),
      ),
    );
  }
}
