import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival/services/FireConn.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/models/event_status.dart';
import 'package:uuid/uuid.dart';

class FestivalService {
  var uuid = const Uuid();

  Festival? festival;

  static final FestivalService _singleton = initialize();

  FestivalService._internal();

  factory FestivalService() {
    return _singleton;
  }

  static CollectionReference festivalCollectionReference =
      festivalCollectionReference;

  static initialize() {
    festivalCollectionReference = FireConn().getFestivalCollection();
    return FestivalService._internal();
  }

  modifyStatus(EventStatus event) {
    festival?.status = event;
  }

  modifyFestival(
      String id,
      EventStatus status,
      String name,
      String city,
      String postalCode,
      String majorField,
      String webSite,
      String creatorId,
      String contactEmail,
      int availableTickets,
      double longitude,
      double latitude) {
    festival?.setAll(id, status, name, city, postalCode, majorField, webSite,
        creatorId, contactEmail, availableTickets, longitude, latitude);
  }

  createFestival(
      EventStatus status,
      String name,
      String city,
      String postalCode,
      String majorField,
      String webSite,
      String creatorId,
      String contactEmail,
      int availableTickets,
      double longitude,
      double latitude) {
    festival?.id = uuid.v4();
    festival?.status = status;
    festival?.name = name;
    festival?.city = city;
    festival?.postalCode = postalCode;
    festival?.majorField = majorField;
    festival?.webSite = webSite;
    festival?.creatorId = creatorId;
    festival?.contactEmail = contactEmail;
    festival?.availableTickets = availableTickets;
    festival?.longitude = longitude;
    festival?.latitude = latitude;
  }
}
