import 'package:festival/models/event_status.dart';
import 'package:festival/models/festival.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Festival f = Festival(
  "FEST_30003_24",
  EventStatus.COMPLETE,
  "Écran libre - festival international du court-métrage",
  "Aigues-Mortes",
  "30003",
  "Cinéma, audiovisuel",
  "http://ecranlibre-aiguesmortes.fr",
  "",
  "ecranlibre.aiguesmortes@orange.fr",
  30,
  [43.566091, 4.189267],
);

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
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            context.goNamed('editFest', params: {'uid': widget.festival.id});
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
