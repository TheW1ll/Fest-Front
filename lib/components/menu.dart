import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carousel.dart';
import 'map.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Carousel(),
    Carousel(),
    MapFestivals(),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Festival"),
      ),
      body: Center(

          child: _widgetOptions.elementAt(_selectedIndex)
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: "Recherche"),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Carte")
        ],
        currentIndex: _selectedIndex,
        //  backgroundColor: Color(0x99144693),
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
