import 'dart:convert';
import 'package:festival/services/festival.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

class MapFestivals extends StatefulWidget {
  const MapFestivals({Key? key}) : super(key: key);

  @override
  State<MapFestivals> createState() => _MapFestivalsState();
}

class _MapFestivalsState extends State<MapFestivals> {
  List<Marker> listMarker = [];
  final PopupController _popupLayerController = PopupController();

  @override
  void initState() {
    super.initState();
    getAllMarkers().then((value) {
      listMarker = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    getAllLocationForFestival();
    return MaterialApp(
        home: Scaffold(
      body: FlutterMap(
        options: MapOptions(
            center: LatLng(51, 0.12),
            zoom: 6,
            onTap: (_, __) {
              _popupLayerController.hideAllPopups();
            }),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
              source: "OpenStreetMap contributors", onSourceTapped: null),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            //userAgentPackageName: 'com.example.app',
          ),
          MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                  markers: listMarker,
                  popupOptions: PopupOptions(
                      popupBuilder: (BuildContext b, Marker m) {
                        return popUp(m.key
                            .toString()
                            .replaceAll("[<'", "")
                            .replaceAll("'>]", ""));
                      },
                      popupSnap: PopupSnap.markerTop,
                      popupController: _popupLayerController,
                      popupState: PopupState(initiallySelectedMarkers: [])),
                  maxClusterRadius: 120,
                  size: const Size(40, 40),
                  fitBoundsOptions:
                      const FitBoundsOptions(padding: EdgeInsets.all(50)),
                  builder: (BuildContext context, List<Marker> markers) {
                    return FloatingActionButton(
                      onPressed: null,
                      child: Text(markers.length.toString()),
                    );
                  })),
        ],
      ),
    ));
  }

  Widget popUp(String name) {
    return Container(
      width: 200,
      height: 30,
      color: Colors.white.withOpacity(0.8),
      child: Row(
        children: [
          Text(name),
          Expanded(
            child: Container(),
          ),
          IconButton(
              padding: const EdgeInsets.only(bottom: 2),
              onPressed: () {
                FestivalService().getIdFestByName(name).then((value) {
                  if (value != null) {
                    context.goNamed('details', params: {'uid': value});
                  }
                });
              },
              icon: const Icon(Icons.add))
        ],
      ),
    );
  }

  Widget markerOnMap(String name) {
    return const Icon(Icons.place);
  }

  Future<List<Marker>> getAllMarkers() async {
    Marker marker;
    List<Marker> listMarker = [];
    Map<String, List<double>> map = await getAllLocationForFestival();
    map.forEach((key, value) {
      marker = Marker(
          point: LatLng(value[0], value[1]),
          key: Key(key),
          builder: (context) {
            return markerOnMap(key);
          });
      listMarker.add(marker);
    });
    return listMarker;
  }

  Future<Map<String, List<double>>> getAllLocationForFestival() async {
    Map<String, List<double>> allLoc = {};
    return rootBundle.loadString("festivals.json").then((value) {
      String res = value;
      List<dynamic> data = json.decode(res);
      for (var i = 0; i < data.length; i++) {
        if (data[i].containsKey("name")) {
          String uid = data[i]["name"];
          if (data[i].containsKey("geolocation")) {
            double un = data[i]["geolocation"][0];
            double deux = data[i]["geolocation"][1];
            List<double> l = [un, deux];
            allLoc.putIfAbsent(uid, () => l);
          }
        }
      }
      return allLoc;
    });
  }

  Future<List<Map>> readJsonFile(String filePath) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    return map;
  }
}
