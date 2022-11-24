import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldHome extends StatelessWidget {
  const ScaffoldHome(
      {super.key,
      required this.child,
      this.title,
      this.backLocation = "/home"});

  final Widget child;
  final String? title;
  final String backLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: (title != null) ? Text(title!) : null,
            leading: BackButton(
              onPressed: () => context.go(backLocation),
            )),
        body: child);
  }
}
