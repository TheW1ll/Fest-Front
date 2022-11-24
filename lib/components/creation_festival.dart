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
  final Email = TextEditingController();
  final Name = TextEditingController();
  final MajorField = TextEditingController();
  final City = TextEditingController();
  final PostalCode = TextEditingController();
  final WebSite = TextEditingController();
  final Longitude = TextEditingController();
  final Latitude = TextEditingController();
  final Tickets = TextEditingController();
  static const widthMobile = 700.0;

  @override
  void dispose() {
    super.dispose();
    Email.dispose();
    Name.dispose();
    MajorField.dispose();
    City.dispose();
    PostalCode.dispose();
    WebSite.dispose();
    Longitude.dispose();
    Latitude.dispose();
    Tickets.dispose();
  }

  void isEditing(String? id) async {
    if (id != null) {
      Festival fest = await FestivalService().getById(id);
      //FestivalService().getById(id).then((festival) => fest = festival);
      if (fest.contactEmail != null) {
        Email.text = fest.contactEmail!;
      }
      Name.text = fest.name;
      MajorField.text = fest.majorField;
      City.text = fest.city;
      Tickets.text = fest.availableTickets.toString();
      Longitude.text = fest.geolocation[0].toString();
      Latitude.text = fest.geolocation[1].toString();

      if (fest.postalCode != null) {
        PostalCode.text = fest.postalCode!;
      }
      if (fest.webSite != null) {
        WebSite.text = fest.webSite!;
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
                    controller: Name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Enter a Festival name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A Festival name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: MajorField,
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
                    controller: City,
                    key: const Key("City"),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: "City's Festival",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A city's Festival is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: PostalCode,
                    key: const Key("PostalCode"),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Postal Code of the city',
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
                    controller: Email,
                    key: const Key("Email"),
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Enter an email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'A Festival mail for contact is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: WebSite,
                    key: const Key("WebSite"),
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: "Website's Festival",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A website's festival is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: Longitude,
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
                    controller: Latitude,
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
                    controller: Tickets,
                    key: const Key("Tickets"),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: '',
                        labelText: 'Available tickets',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "A number of tickets available is required";
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
                          style: TextStyle(fontSize: 16),
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
                                    Longitude.text.replaceAll(",", ".")),
                                double.parse(
                                    Latitude.text.replaceAll(",", ".")),
                              ];

                              String idFest = Uuid().v4().toString();

                              int statusInt = status.indexOf(state);

                              String user = "";
                              if (UserService().getLocalUser() != null) {
                                String user = UserService().getLocalUser()!.id;
                              }

                              Festival festival = Festival(
                                  idFest,
                                  EventStatus.values.elementAt(statusInt),
                                  Name.text,
                                  City.text,
                                  PostalCode.text,
                                  MajorField.text,
                                  WebSite.text,
                                  user,
                                  Email.text,
                                  int.parse(Tickets.text),
                                  listLoc);

                              FestivalService()
                                  .createFestivalInDataBase(festival);
                            } else {
                              List<double> listLoc = [
                                double.parse(
                                    Longitude.text.replaceAll(",", ".")),
                                double.parse(
                                    Latitude.text.replaceAll(",", ".")),
                              ];

                              int statusInt = status.indexOf(state);

                              String user = "";
                              if (UserService().getLocalUser() != null) {
                                String user = UserService().getLocalUser()!.id;
                              }

                              Festival festival = Festival(
                                  widget.idFestival.toString(),
                                  EventStatus.values.elementAt(statusInt),
                                  Name.text,
                                  City.text,
                                  PostalCode.text,
                                  MajorField.text,
                                  WebSite.text,
                                  user,
                                  Email.text,
                                  int.parse(Tickets.text),
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
