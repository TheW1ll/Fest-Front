import 'package:festival/components/search.dart';
import 'package:festival/components/paginated_festival_list.dart';
import 'package:flutter/material.dart';

class FestivalListPage extends StatefulWidget {
  const FestivalListPage({Key? key}) : super(key: key);

  @override
  State<FestivalListPage> createState() => _FestivalListPageState();
}

class _FestivalListPageState extends State<FestivalListPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FestivalSearch(),
        Expanded(child: FestivalList())
      ],
    );
  }
}
