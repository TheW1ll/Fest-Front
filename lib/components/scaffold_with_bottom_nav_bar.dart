import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (GoRouter.of(context).location !=
        widget.tabs[tabIndex].initialLocation) {
      // go to the initial location of the selected tab (by index)
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festoche'),
        actions: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () => context.goNamed('profile'),
                icon: const Icon(Icons.account_circle, size: 36),
              )),
        ],
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}
