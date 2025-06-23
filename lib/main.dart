import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/data/models/place_model.dart';
import 'package:fav_route/data/repositories/place_list_repository_impl.dart';
import 'package:fav_route/data/repositories/place_repository_impl.dart';
import 'package:fav_route/domain/repositories/place_list_repository.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_bloc.dart';
import 'package:fav_route/ui/blocs/saved_places_bloc/saved_places_bloc.dart';
import 'package:fav_route/ui/pages/place_list_page.dart';
import 'package:fav_route/ui/pages/saved_places_page.dart';
import 'package:fav_route/ui/widgets/scaffold_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceListAdapter());
  Hive.registerAdapter(PlaceAdapter());
  final placeListBox = await Hive.openBox<PlaceList>('placeLists');
  await Hive.openBox<Place>('places');

  // Ensure default "Favorites" list exists
  const favoritePlaceListName = 'Favorites';
  final exists =
      placeListBox.values.any((c) => c.name == favoritePlaceListName);
  if (!exists) {
    final general = PlaceList(
      id: const Uuid().v4(),
      name: favoritePlaceListName,
    );
    await placeListBox.put(general.id, general);
  }

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
              const NoTransitionPage(child: PlaceListPage()),
        ),
        GoRoute(
          path: '/lists',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: SavedPlacesPage()),
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
          RepositoryProvider<PlaceRepository>(
              create: (context) => PlaceRepositoryImpl()),
          RepositoryProvider<PlaceListRepository>(
              create: (context) => PlaceListRepositoryImpl()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (ctx) =>
                      SavedPlacesBloc(ctx.read<PlaceListRepository>())),
              BlocProvider(
                  create: (ctx) =>
                      PlaceBloc(repository: ctx.read<PlaceRepository>())),
            ],
            child: MaterialApp.router(
              title: 'Favorite Route',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routerConfig: _router,
            )));
  }
}
