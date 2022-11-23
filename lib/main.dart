import 'package:festival/firebase_options.dart';
import 'package:festival/login.dart';
import 'package:festival/register.dart';
import 'package:festival/services/auth.service.dart';
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

final GoRouter _router = GoRouter(
  errorBuilder: errorPageBuilder,
  redirect: (context, state) {
    final isLoggedIn = UserService().isLoggedIn();
    final isLoggingIn = state.location == '/login';
    final isRegistering = state.location == '/register';

    if (!isLoggedIn) {
      return (!isRegistering && !isLoggedIn) ? '/login' : null;
    } else if (isLoggingIn) {
      return '/home';
    }
    return null;
  },
  refreshListenable: UserService(),
  routes: <GoRoute>[
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
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    )
  ],
  initialLocation: '/home',
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<HomePage> {
  String status = UserService().isLoggedIn() ? "Logged" : "Not logged";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Festoche'),
        ),
        body: Column(
          children: [
            const Text('APP'),
            Text(status),
            ElevatedButton(
                onPressed: () {
                  AuthService().signOut();
                },
                child: const Text('Sign out')),
            ElevatedButton(
                onPressed: () {
                  context.goNamed('login');
                },
                child: const Text('Login'))
          ],
        ));
  }
}

Widget errorPageBuilder(BuildContext context, GoRouterState state) {
  return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      )) as Widget;
}
