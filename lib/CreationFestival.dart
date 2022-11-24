import 'package:festival/models/event_status.dart';
import 'package:flutter/material.dart';
import 'package:festival/firebase_options.dart';
import 'package:festival/services/auth.service.dart';
import 'package:festival/services/user.service.dart';
import 'package:firebase_core/firebase_core.dart';

class CreationFestival extends StatefulWidget {
  var contactEmail = 'test';
  var name = "";
  var majorField = "";
  var city = "";
  int postalCode = 0;
  var webSite = "";
  double longitude = 0.0;
  double latitude = 0.0;
  int availableTickets = 0;
  //EventStatus status = 0;

  @override
  _CFState createState() => _CFState();
}

class _CFState extends State<CreationFestival> {
  var contactEmail = '';
  var name = "Le plus beau festival du monde";
  var majorField = "Arts visuels, Litérature, Musique, etc.";
  var city = "";
  int postalCode = 0;
  var webSite = "";
  double longitude = 0.0;
  double latitude = 0.0;
  int availableTickets = 0;
  //EventStatus status = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Creation de votre festival')),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: '$contactEmail',
                    labelText: 'Votre adresse mail',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: '$name',
                    labelText: 'Entrer son nom',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: '$majorField',
                    labelText: 'Discipline dominante',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                    hintText: '$city',
                    labelText: 'Ville qui acceuil le festival',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '$postalCode',
                    labelText: 'Code postal de la ville',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                    hintText: '$webSite',
                    labelText: 'Site web du festival',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '$longitude',
                    labelText: 'Longitude',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '$latitude',
                    labelText: 'Latitude',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: '$availableTickets',
                    labelText: 'Nombre de tickets disponibles',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: '',
                    labelText: 'Status des ventes',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0)))),
            SizedBox(
              height: 16,
            ),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.purple),
                    onPressed: () {},
                    child: Text('Valider')),
              ),
            ])
          ],
        )),
      ),
    );
  }
}
