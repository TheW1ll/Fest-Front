import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festival/components/festival_list_item.dart';
import 'package:festival/services/festival.service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/festival.dart';

class FestivalList extends StatefulWidget {
  const FestivalList({Key? key, this.nameField, this.genreField})
      : super(key: key);

  final String? nameField;
  final String? genreField;

  @override
  State<FestivalList> createState() => _FestivalListState();
}

class _FestivalListState extends State<FestivalList> {
  late bool _isLastPage;
  late DocumentSnapshot? _lastFestival;
  late bool _error;
  late bool _loading;
  final int _numberOfItemsPerRequest = 10;
  late List<Festival> _festivals;
  final int _nextPageTrigger = 3;

  @override
  void initState() {
    super.initState();
    _lastFestival = null;
    _festivals = [];
    _isLastPage = false;
    _loading = true;
    _error = false;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await FestivalService().getNextFestivals(_lastFestival,
          _numberOfItemsPerRequest, widget.nameField, widget.genreField);
      List<Festival> festivalList = result.item1;

      setState(() {
        _isLastPage = festivalList.length < _numberOfItemsPerRequest;
        _loading = false;
        _lastFestival = result.item2;
        _festivals.addAll(festivalList);
      });
    } catch (e) {
      if (kDebugMode) {
        print("error --> $e");
      }
      setState(() {
        _loading = false;
        _error = true;
      });
    }
  }

  Widget errorDialog({required double size}) {
    return SizedBox(
      height: 180,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An error occurred when fetching the posts.',
            style: TextStyle(
                fontSize: size,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          const SizedBox(height: 10),
          TextButton(
              onPressed: () {
                setState(() {
                  _loading = true;
                  _error = false;
                  fetchData();
                });
              },
              child: const Text(
                "Retry",
                style: TextStyle(fontSize: 20, color: Colors.blueAccent),
              )),
        ],
      ),
    );
  }

  Widget buildFestivalsView() {
    if (_festivals.isEmpty) {
      if (_loading) {
        return const Center(
            child: Padding(
          padding: EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(child: errorDialog(size: 20));
      }
    }
    return ListView.builder(
        itemCount: _festivals.length + (_isLastPage ? 0 : 1),
        itemBuilder: (context, index) {
          if (index == _festivals.length - _nextPageTrigger) {
            fetchData();
          }
          if (index == _festivals.length) {
            if (_error) {
              return Center(child: errorDialog(size: 15));
            } else {
              return const Center(
                  child: Padding(
                padding: EdgeInsets.all(8),
                child: CircularProgressIndicator(),
              ));
            }
          }
          final Festival festival = _festivals[index];
          return FestivalListItem(festival: festival);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: buildFestivalsView(),
    );
  }
}
