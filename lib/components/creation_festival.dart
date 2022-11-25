import 'package:festival/models/event_status.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/services/festival.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:festival/services/user.service.dart';

class CreationFestival extends StatefulWidget {
  String? idFestival;

  CreationFestival({super.key, this.idFestival});

  @override
  _CFState createState() => _CFState();
}

class _CFState extends State<CreationFestival> {
  var formKey = GlobalKey<FormState>();
  final List<String> status = ['OPEN_TICKETING', 'LAST_TICKETS', 'COMPLETE'];
  String state = 'COMPLETE';
  final email = TextEditingController();
  final name = TextEditingController();
  final majorField = TextEditingController();
  final city = TextEditingController();
  final postalCode = TextEditingController();
  final webSite = TextEditingController();
  final longitude = TextEditingController();
  final latitude = TextEditingController();
  final tickets = TextEditingController();
  static const widthMobile = 700.0;

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    name.dispose();
    majorField.dispose();
    city.dispose();
    postalCode.dispose();
    webSite.dispose();
    longitude.dispose();
    latitude.dispose();
    tickets.dispose();
  }

  void isEditing(String? id) async {
    if (id != null) {
      Festival fest = await FestivalService().getById(id);
      if (fest.contactEmail != null) {
        email.text = fest.contactEmail!;
      }
      name.text = fest.name;
      majorField.text = fest.majorField;
      city.text = fest.city;
      tickets.text = fest.availableTickets.toString();
      longitude.text = fest.geolocation[0].toString();
      latitude.text = fest.geolocation[1].toString();

      if (fest.postalCode != null) {
        postalCode.text = fest.postalCode!;
      }
      if (fest.webSite != null) {
        webSite.text = fest.webSite!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    isEditing(widget.idFestival);
    double widthWeb = MediaQuery.of(context).size.width;

    if (widthMobile <= MediaQuery.of(context).size.width) {
      widthWeb = widthWeb / 10;
    } else {
      widthWeb = 10;
    }

    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.all(widthWeb),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key("Name"),
                    controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Enter a Festival name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: majorField,
                    key: const Key("MajorField"),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Major Field',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A major field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: city,
                    key: const Key("City"),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: "City's Festival",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A city is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: postalCode,
                    key: const Key("PostalCode"),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Postal code',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A postal code is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: email,
                    key: const Key("Email"),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Enter an email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A contact email is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: webSite,
                    key: const Key("WebSite"),
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: "Festival's website",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A website is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: longitude,
                    key: const Key("Longitude"),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Longitude',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A longitude is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: latitude,
                    key: const Key("Latitude"),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Latitude',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A latitude is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: tickets,
                    key: const Key("Tickets"),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Available tickets',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A number of available tickets is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DropdownButton<String>(
                    key: const Key("Status"),
                    value: state,
                    items: status.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        state = newValue!;
                      });
                    },
                  ),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: () {
                            if (widget.idFestival == null) {
                              List<double> listLoc = [
                                double.parse(
                                    longitude.text.replaceAll(",", ".")),
                                double.parse(
                                    latitude.text.replaceAll(",", ".")),
                              ];

                              String idFest = const Uuid().v4().toString();

                              int statusInt = status.indexOf(state);

                              String user =
                                  UserService().getLocalUser()?.id ?? '';

                              Festival festival = Festival(
                                  idFest,
                                  EventStatus.values.elementAt(statusInt),
                                  name.text,
                                  city.text,
                                  postalCode.text,
                                  majorField.text,
                                  webSite.text,
                                  user,
                                  email.text,
                                  int.parse(tickets.text),
                                  listLoc);

                              FestivalService()
                                  .createFestivalInDataBase(festival);
                            } else {
                              List<double> listLoc = [
                                double.parse(
                                    longitude.text.replaceAll(",", ".")),
                                double.parse(
                                    latitude.text.replaceAll(",", ".")),
                              ];

                              int statusInt = status.indexOf(state);

                              String user =
                                  UserService().getLocalUser()?.id ?? "";

                              Festival festival = Festival(
                                  widget.idFestival.toString(),
                                  EventStatus.values.elementAt(statusInt),
                                  name.text,
                                  city.text,
                                  postalCode.text,
                                  majorField.text,
                                  webSite.text,
                                  user,
                                  email.text,
                                  int.parse(tickets.text),
                                  listLoc);
                              FestivalService()
                                  .modifyFestivalInDataBase(festival);
                            }
                            context.goNamed('home');
                          },
                          child: const Text('Validate')),
                    ),
                  ])
                ],
              ))),
    );
  }
}
