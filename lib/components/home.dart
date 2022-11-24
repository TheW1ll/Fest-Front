import 'package:festival/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String status = UserService().isLoggedIn() ? "Logged" : "Not logged";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('APP'),
        Text(status),
        ElevatedButton(
            onPressed: () {
              context.goNamed('login');
            },
            child: const Text('Login'))
      ],
    );
  }
}
