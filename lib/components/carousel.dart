import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:festival/services/festival.service.dart';
import 'package:flutter/material.dart';

import '../models/festival.dart';

class Carousel extends StatefulWidget {
  const Carousel({Key? key}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  List<Festival> listFestival = [];
  int numberOfRandom = 4;
  CarouselController buttonCarousel = CarouselController();
  int sizeMobile = 700;

  @override
  void initState() {
    FestivalService().getRandomFestival(numberOfRandom).then((value) {
      listFestival = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: carouselFest());
  }

  Widget carouselFest() {


    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.6,
        alignment:  Alignment.topCenter,
        margin: MediaQuery.of(context).size.width > sizeMobile ? const EdgeInsets.only(top: 30) : null,
        child: CarouselSlider(
            carouselController: buttonCarousel,
            items: listFestival
                .map((e) => Builder(
                      builder: (BuildContext context) {
                        var size = MediaQuery.of(context).size;

                        //Generate link for image for each festivals
                        Map<String, String> map = {};
                        int i = 1;
                        for (var element in listFestival) {
                          map.putIfAbsent(element.id, () => "https://picsum.photos/${size.height.ceil()}/${size.width.ceil()}?random=$i");
                          i++;
                        }
                        return SizedBox(
                            width: MediaQuery.of(context).size.width > sizeMobile ? MediaQuery.of(context).size.width - 400 : MediaQuery.of(context).size.width, height: 100,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  width: size.width,
                                  height: size.height,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: CachedNetworkImageProvider(map[e.id]!),
                                    fit: BoxFit.fitWidth,
                                  )),
                                  alignment: Alignment.center,
                                  // width: MediaQuery.of(context).size.width ,
                                  // height: 100,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/8),
                                  color: Colors.white,
                                  child: Text(e.name),
                                  width: 300,
                                  height: 100,
                                )
                              ],
                            ));
                      },
                    ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 2),
            )));
  }

}
