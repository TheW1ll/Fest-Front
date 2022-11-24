import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldHome extends StatelessWidget {
  const ScaffoldHome({super.key, required this.child, String? this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: (title != null) ? Text(title!) : null,
            leading: BackButton(
              onPressed: () => context.goNamed('home'),
            )),
        body: child);
  }
}
