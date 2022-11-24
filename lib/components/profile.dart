import 'package:festival/services/auth.service.dart';
import 'package:festival/services/user.service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Profile'),
          leading: BackButton(
            onPressed: () => context.goNamed('home'),
          )),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 119, 119, 119),
                ),
                const SizedBox(width: 16),
                Text(
                  (UserService().getEmail() ?? "No email"),
                  style: const TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          const SizedBox(height: 36),
          Container(
            decoration: const BoxDecoration(
                border: Border.symmetric(
              horizontal: BorderSide(width: 1, color: Colors.black),
            )),
            child: InkWell(
              onTap: () => AuthService().signOut(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(children: const [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 16),
                  Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.red),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
