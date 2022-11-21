import 'dart:ffi';
import 'package:festival/models/event_status.dart';

class Festival {
    String id;
    EventStatus status;
    String name;
    String city;
    String postalCode;
    String majorField;
    String webSite;
    String creatorId;
    String contactEmail;
    int availableTickets;
    double longitude;
    double latitude;
    



Festival(this.id, this.status, this.name, this.city, this.postalCode, this.majorField, this.webSite, this.creatorId, this.contactEmail, this.availableTickets, this.longitude, this.latitude);
  
  factory Festival.from(dynamic json) {
    return Festival(
      json['id'] as String,
      EventStatus.values[json['status'] as int],
      json['Nom du festival'] as String,
      json['Commune principale de déroulement'] as String,
      json['Code postal'] as String,
      json['Discipline dominante'] as String,
      json['Site internet du festival'] as String,
      json['geolocalisation'] as String,
      json['Adresse e-mail'] as String,
      json['geolocalisation'] as int,
      json['longitude'] as double,
      json['latitude'] as double,
    );
  }

  toJson() {
    return {
      'id': id,
      'status': status.index,
      'name': name,
      'city': city,
      'postalCode': postalCode,
      'majorField': majorField,
      'website': webSite,
      'creatorId': creatorId,
      'contactEmail': contactEmail,
      'availableTickets': availableTickets,
      'longitude': longitude,
      'latitude': latitude
    };
  }

  getId(){
    return this.id;
  }

  getStatus(){
    return this.status;
  }
  getName(){
    return this.name;
  }

    getCity(){
      return this.city;
    }

    getPostalCode(){
      return this.postalCode;
    }

    getMajorField(){
      return this.majorField;
    }
    getWebSite(){
      return this.majorField;
    }
    getCreatorId(){
      return this.creatorId;
    }
    getContactEmail(){
      return this.contactEmail;
    }

    getAvailableTickets(){
      return this.contactEmail;
    }
    getLatitude(){
      return this.latitude;
    }

    getLongitude(){
    return this.longitude;
    }
    setAll(String id, EventStatus status, String name, String city, String postalCode, String majorField, String webSite, String creatorId, String contactEmail, int availableTickets, double longitude, double latitude){
      this.id=id;
      this.status=status;
      this.name=name;
      this.city=city;
      this.postalCode=postalCode;
      this.majorField=majorField;
      this.webSite=webSite;
      this.creatorId=creatorId;
      this.contactEmail=contactEmail;
      this.availableTickets=availableTickets;
      this.longitude=longitude;
      this.latitude=latitude;
    }



}
