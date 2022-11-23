import 'package:festival/details.dart';
import 'package:festival/components/paginated_festival_list.dart';
import 'package:festival/firebase_options.dart';
import 'package:festival/login.dart';
import 'package:festival/models/festival.dart';
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

Festival? festival;

final GoRouter _router = GoRouter(
  errorBuilder: (context, state) => ErrorPage(state: state),
  redirect: (context, state) {
    debugPrint(state.location.toString());
    //   final isLoggedIn = UserService().isLoggedIn();
    //   final isLoggingIn = state.location == '/login';
    //   final isRegistering = state.location == '/register';

    //   if (!isLoggedIn) {
    //     if (!isRegistering && !isLoggedIn) return '/login';
    //   } else if (isLoggingIn) {
    //     return '/home';
    //   }

    //   return null;
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
      name: 'error',
      path: '/error',
      builder: (context, state) => ErrorPage(state: state),
    ),
    ShellRoute(
        builder: ((context, state, child) => ScaffoldWithBottomNavBar(
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
            )),
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
              debugPrint(state.location.toString());
              String? uid = state.params['uid'];
              if (uid != null) {
                festival = await getFestival(uid);
                if (festival != null) {
                  return null;
                }
              }

              return "/error?errormsg=Festival%20not%20found"; // Exception('Festival not found');
            },
            name: 'details',
            path: '/details/:uid',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: DetailsPage(festival: festival!)),
          ),
        ])
  ],
  initialLocation: '/details/FEST_01053_980',
);

Future<Festival?> getFestival(String uid) {
  return Future.value(f);
}

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
              AuthService().signOut();
            },
            child: const Text('Sign out')),
        ElevatedButton(
            onPressed: () {
              context.goNamed('login');
            },
            child: const Text('Login'))
      ],
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.state});

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    String errorMsg = (state.error != null)
        ? state.error.toString()
        : state.queryParams['errormsg'].toString();
    return Scaffold(
      key: state.pageKey,
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}

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
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Festoche'),
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
