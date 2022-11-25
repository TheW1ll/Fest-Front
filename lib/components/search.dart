import 'package:festival/components/festival_list_item.dart';
import 'package:flutter/material.dart';
import 'package:festival/services/festival.service.dart';
import 'package:festival/models/festival.dart';

class FestivalSearch extends StatefulWidget {
  const FestivalSearch({super.key});

  @override
  State<StatefulWidget> createState() => _FestivalSearchState();
}

class CustomSearchDelegate extends SearchDelegate {
  List<Festival> _festivalsSearch = [];

  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  // pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // to show query result
  @override
  Widget buildResults(BuildContext context) {
    FestivalService().filterFestival(query).then((value) {
      _festivalsSearch = value;
    });

    return ListView.builder(
      itemCount: _festivalsSearch.length,
      itemBuilder: (context, index) {
        var result = _festivalsSearch[index];
        return ListTile(
          title: Text(result.getName()),
          subtitle: Text(result.getMajorField()),
        );
      },
    );
  }

  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    FestivalService().searchFestival(query).then((value) {
      _festivalsSearch = value;
    });

    return ListView.builder(
      itemCount: _festivalsSearch.length,
      itemBuilder: (context, index) {
        var result = _festivalsSearch[index];
        return FestivalListItem(festival: _festivalsSearch[index]);
      },
    );
  }
}

class _FestivalSearchState extends State<FestivalSearch> {
  // Initial Selected Value
  String dropdownValue = 'Musique';

  // List of items
  var items = [
    'Musique',
    'Pluridisciplinaire',
    'Cinéma, audiovisuel',
    'Spectacle vivant',
    'Livre, littérature',
  ];

  List<Festival> _festivals = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            icon: IconButton(
              onPressed: () {
                // method to show the search bar
                showSearch(
                    context: context,
                    // delegate to customize the search bar
                    delegate: CustomSearchDelegate());
              },
              icon: const Icon(Icons.search),
            )),
        DropdownButton(
          // Initial Value
          value: dropdownValue,

          // Down Arrow Icon
          icon: const Icon(Icons.keyboard_arrow_down),
          // Array list of items
          items: items.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Text(items),
            );
          }).toList(),
          // After selecting the desired option,it will
          // change button value to selected value
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue.toString();
              print(newValue.toString());
              FestivalService()
                  .filterFestival(newValue.toString())
                  .then((value) {
                _festivals = value;
                try {
                  print(_festivals.first.getName().toString());
                  print(_festivals.last.getName().toString());
                } catch (err) {
                  print(err);
                }
              });
            });
          },
        ),
      ],
    );
  }
}
