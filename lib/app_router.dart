import 'package:fav_route/domain/repositories/place_list_repository.dart'
    show PlaceListRepository;
import 'package:fav_route/ui/blocs/place_bloc/place_bloc.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_event.dart';
import 'package:fav_route/ui/blocs/saved_places_bloc/saved_places_bloc.dart';
import 'package:fav_route/ui/blocs/saved_places_bloc/saved_places_event.dart';
import 'package:fav_route/ui/pages/place_list_page.dart';
import 'package:fav_route/ui/pages/saved_places_page.dart';
import 'package:fav_route/ui/widgets/scaffold_with_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'domain/repositories/place_repository.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter extends StatelessWidget {
  final String favoriteListId;

  const AppRouter({super.key, required this.favoriteListId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Favorite Route',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        initialLocation: '/list/$favoriteListId',
        routes: <RouteBase>[
          ShellRoute(
            navigatorKey: rootNavigatorKey,
            builder: (context, state, child) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<SavedPlacesBloc>(
                    create: (_) =>
                        SavedPlacesBloc(context.read<PlaceListRepository>())
                          ..add(LoadSavedPlaces()),
                  ),
                  BlocProvider<PlaceBloc>(
                    create: (_) {
                      // grab the current listId param, but default to favorites
                      final listId =
                          state.pathParameters['listId'] ?? favoriteListId;
                      return PlaceBloc(
                        placeListId: listId,
                        placeRepository: context.read<PlaceRepository>(),
                        placeListRepository:
                            context.read<PlaceListRepository>(),
                      )..add(LoadPlace(
                          placeList: context
                              .read<PlaceListRepository>()
                              .getPlaceList(listId)));
                    },
                  ),
                ],
                child: ScaffoldWithBottomNav(child: child),
              );
            },
            routes: [
              GoRoute(
                path: '/list/:listId',
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
      ),
    );
  }
}
