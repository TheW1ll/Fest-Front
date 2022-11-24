import 'package:festival/components/favorite_list.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/services/auth.service.dart';
import 'package:festival/services/festival.service.dart';
import 'package:festival/services/user.service.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late List<Festival> favoriteList = [];

  @override
  void initState() {
    fetchFavoriteFestivals().then((festivals) => setState(() {
          favoriteList = festivals;
        }));
    super.initState();
  }

  Future<List<Festival>> fetchFavoriteFestivals() {
    final localUser = UserService().getLocalUser();
    if (localUser == null) return Future.value([]);

    return Future.wait(
        localUser.favoriteFestivals.map((id) => FestivalService().getById(id)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        ),
        Expanded(child: FestivalList(favoriteList: favoriteList))
      ],
    );
  }
}
