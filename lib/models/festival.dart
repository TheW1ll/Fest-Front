import 'package:festival/models/event_status.dart';

class Festival {
  String id;
  EventStatus status;
  String name;
  String city;
  String? postalCode;
  String majorField;
  String? webSite;
  String creatorId;
  String? contactEmail;
  int availableTickets;
  List<double> geolocation;

  Festival(
      this.id,
      this.status,
      this.name,
      this.city,
      this.postalCode,
      this.majorField,
      this.webSite,
      this.creatorId,
      this.contactEmail,
      this.availableTickets,
      this.geolocation);

  factory Festival.from(dynamic json) {
    return Festival(
        json['id'],
        EventStatus.values[json['status'] as int],
        json['name'],
        json['city'],
        json['postalCode'],
        json['majorField'],
        json['webSite'],
        json["creatorId"],
        json['contactEmail'],
        json['availableTickets'],
        (json["geolocation"] as List).map((e) => e as double).toList());
  }

  toJson() {
    return {
      'id': id,
      'status': status.index,
      'name': name,
      'city': city,
      'postalCode': postalCode,
      'majorField': majorField,
      'webSite': webSite,
      'creatorId': creatorId,
      'contactEmail': contactEmail,
      'availableTickets': availableTickets,
      'geolocation': geolocation,
    };
  }

  getId() {
    return id;
  }

  getStatus() {
    return status;
  }

  getName() {
    return name;
  }

  getCity() {
    return city;
  }

  getPostalCode() {
    return postalCode;
  }

  getMajorField() {
    return majorField;
  }

  getWebSite() {
    return majorField;
  }

  getCreatorId() {
    return creatorId;
  }

  getContactEmail() {
    return contactEmail;
  }

  getAvailableTickets() {
    return availableTickets;
  }

  setAll(
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
    this.id = id;
    this.status = status;
    this.name = name;
    this.city = city;
    this.postalCode = postalCode;
    this.majorField = majorField;
    this.webSite = webSite;
    this.creatorId = creatorId;
    this.contactEmail = contactEmail;
    this.availableTickets = availableTickets;
  }
}
