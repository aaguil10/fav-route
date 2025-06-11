import 'package:fav_route/data/models/place.dart';
import 'package:fav_route/data/repositories/place_service.dart';
import 'package:fav_route/ui/pages/favorites_page.dart';
import 'package:fav_route/ui/pages/lists_page.dart';
import 'package:fav_route/ui/widgets/scaffold_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceAdapter());
  await Hive.openBox<Place>('places');
  runApp(const MyApp());
}

final rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  initialLocation: '/favorites',
  routes: <RouteBase>[
    ShellRoute(
      navigatorKey: rootNavigatorKey,
      builder: (context, state, child) {
        return ScaffoldWithBottomNav(child: child);
      },
      routes: [
        GoRoute(
          path: '/favorites',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: FavoritesPage()),
        ),
        GoRoute(
          path: '/lists',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ListsPage()),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => PlaceService()),
        ],
        child: MaterialApp.router(
          title: 'Favorite Route',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          routerConfig: _router,
        ));
  }
}
