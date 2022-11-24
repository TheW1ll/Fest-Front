import 'package:festival/components/error.dart';
import 'package:festival/components/home.dart';
import 'package:festival/components/profile.dart';
import 'package:festival/components/scaffold_with_bottom_nav_bar.dart';
import 'package:festival/details.dart';
import 'package:festival/firebase_options.dart';
import 'package:festival/login.dart';
import 'package:festival/models/festival.dart';
import 'package:festival/register.dart';
import 'package:festival/services/user.service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

Festival? festival;

final GoRouter _router = GoRouter(
  errorBuilder: (context, state) =>
      ErrorPage(msg: 'Could not find location', sub: state.location.toString()),
  redirect: (context, state) {
    debugPrint(state.location.toString());
    // final isLoggedIn = UserService().isLoggedIn();
    // final isLoggingIn = state.location == '/login';
    // final isRegistering = state.location == '/register';

    // if (!isLoggedIn) {
    //   if (!isRegistering && !isLoggedIn) return '/login';
    // } else if (isLoggingIn) {
    //   return '/home';
    // }

    // return null;
  },
  refreshListenable: UserService(),
  routes: [
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'register',
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: Profile(),
      ),
    ),
    ShellRoute(
        pageBuilder: ((context, state, child) => MaterialPage(
            child: ScaffoldWithBottomNavBar(
              tabs: const [
                ScaffoldWithNavBarTabItem(
                  initialLocation: '/home',
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                ScaffoldWithNavBarTabItem(
                  initialLocation: '/details/1',
                  icon: Icon(Icons.settings),
                  label: 'Details',
                ),
              ],
              child: child,
            ))),
        routes: [
          GoRoute(
            name: 'home',
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
          ),
          GoRoute(
            redirect: (context, state) async {
              String? uid = state.params['uid'];
              if (uid != null) {
                festival = await getFestival(uid);
              }
              return null;
            },
            name: 'details',
            path: '/details/:uid',
            pageBuilder: (context, state) {
              return NoTransitionPage(
                child: (festival == null)
                    ? const ErrorPage(msg: 'Festival not found')
                    : DetailsPage(festival: festival!),
              );
            },
          ),
        ])
  ],
  initialLocation: '/details/FEST_01053_980',
);

Future<Festival?> getFestival(String uid) {
  return Future.value(null);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
