import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.msg, this.sub});

  final String msg;
  final String? sub;

  @override
  Widget build(BuildContext context) {
    List<Widget> msgs = [
      Text(
        msg,
        style: const TextStyle(fontSize: 24),
      )
    ];
    if (sub != null) {
      msgs.addAll([
        const SizedBox(height: 8),
        Text(
          sub!,
          style: const TextStyle(
              fontSize: 20, color: Color.fromARGB(255, 97, 97, 97)),
        )
      ]);
    }

    return Scaffold(
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.center, children: msgs),
      ),
    );
  }
}
