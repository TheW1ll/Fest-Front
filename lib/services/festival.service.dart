import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival/services/FireConn.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/models/event_status.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';

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

  Future<Tuple2<List<Festival>, DocumentSnapshot>> getNextFestivals(
      DocumentSnapshot? startAt, int numberOfItems) async {
    late QueryDocumentSnapshot lastFestival;
    Query query = festivalCollectionReference.orderBy("name");

    if (startAt != null) {
      query = query.startAfterDocument(startAt).limit(numberOfItems);
    } else {
      query = query.limit(numberOfItems);
    }

    final festivals = await query.get().then((value) {
      lastFestival = value.docs.last;
      return value.docs
          .map((e) => Festival.from(e.data() as Map<String, dynamic>))
          .toList();
    });
    return Future.value(Tuple2(festivals, lastFestival));
  }

  Future<List<Festival>> getAllFestivals() {
    return festivalCollectionReference.get().then((value) {
      final allFest = value.docs
          .map((festival) =>
              Festival.from(festival.data() as Map<String, dynamic>))
          .toList();
      return allFest;
    });
  }

  Future<String?> getIdFestByName(String name) {
    return festivalCollectionReference
        .where("name", isEqualTo: name)
        .get()
        .then((value) {
      final allFest = value.docs
          .map((festival) =>
              Festival.from(festival.data() as Map<String, dynamic>))
          .toList();
      if (allFest.isNotEmpty) {
        return allFest[0].id;
      } else {
        return null;
      }
    });
  }

  Future writeDataInJson(Festival fest) async {
    var input = await File("festival.json").readAsString();
    List<dynamic> data = json.decode(input);
    data.add(MapEntry(fest.name, fest.geolocation));
    File("festival.json").writeAsString(data.toString());
  }

  Future<List<Festival>> getRandomFestival(int numberOfRandom) {
    return festivalCollectionReference
        .limit(numberOfRandom)
        .get()
        .then((value) {
      final listFest = value.docs
          .map((e) => Festival.from(e.data() as Map<String, dynamic>))
          .toList();
      return listFest;
    });
  }

  modifyStatus(EventStatus event) {
    festival?.status = event;
  }

  Future createFestivalInDataBase(Festival festival) async {
    festivalCollectionReference.doc(festival.id).set(festival.toJson());
  }

  Future modifyFestivalInDataBase(Festival festival) async {
    festivalCollectionReference.doc(festival.id).update(festival.toJson());
  }

  Future<Festival> getById(String id) async {
    return festivalCollectionReference.doc(id).get().then((fest) {
      festival = Festival.from(fest.data() as Map<String, dynamic>);
      return festival!;
    });
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
    festival?.geolocation = [longitude, latitude];
  }
}
