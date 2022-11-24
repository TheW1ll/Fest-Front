import 'package:festival/components/star_button.dart';
import 'package:festival/models/event_status.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    super.key,
    required this.festival,
  });

  final Festival festival;

  @override
  State<StatefulWidget> createState() => _DetailPageSate();
}

class _DetailPageSate extends State<DetailsPage> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = _isFavoriteOfCurrentUser();
    super.initState();
  }

  TableRow row(String property, String value) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(property),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(value),
      ),
    ]);
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

  void _shareWebsite() {
    if (widget.festival.webSite != null) {
      Share.share(widget.festival.webSite!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? status;

    switch (widget.festival.status) {
      case EventStatus.COMPLETE:
        status = "Complete";
        break;
      case EventStatus.LAST_TICKETS:
        status = "Last Ticket";
        break;
      case EventStatus.OPEN_TICKETING:
        status = "Open Ticketing";
        break;
      default:
        status = "Unknown status";
    }

    String website =
        (widget.festival.webSite != null) ? widget.festival.webSite! : "";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text("Favoris :"),
          StarButton(
              isFavorite: _isFavoriteOfCurrentUser(),
              onButtonClicked: _onStarButtonClicked),
        ]),
        Table(
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            row("Name : ", widget.festival.name),
            row("Status : ", status),
            row("Adresse : ",
                "${widget.festival.city} (${widget.festival.postalCode})"),
            row("Theme : ", widget.festival.majorField),
            row("Available tickets : ",
                widget.festival.availableTickets.toString()),
            row("Website : ", website),
          ],
        ),
        ElevatedButton.icon(
          onPressed: () {
            _shareWebsite();
          },
          icon: const Icon(Icons.share),
          label: const Text(
            "Share",
          ),
        ),
        const SizedBox(height: 16),
        (UserService().getLocalUser()?.id != widget.festival.creatorId &&
                !UserService().isAdmin())
            ? Container()
            : ElevatedButton.icon(
                onPressed: () {
                  context
                      .goNamed('editFest', params: {'uid': widget.festival.id});
                },
                icon: const Icon(Icons.edit),
                label: const Text(
                  "Edit",
                ),
              ),
      ]),
    );
  }
}
