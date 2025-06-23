import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/data/models/place_model.dart';
import 'package:fav_route/data/repositories/place_list_repository_impl.dart';
import 'package:fav_route/data/repositories/place_repository_impl.dart';
import 'package:fav_route/domain/repositories/place_list_repository.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initHive();
  final favoriteListId = _ensureFavoritesList();
  runApp(MyApp(favoriteListId: favoriteListId));
}

Future<void> _initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceListAdapter());
  Hive.registerAdapter(PlaceAdapter());
  await Hive.openBox<PlaceList>('placeLists');
  await Hive.openBox<Place>('places');
}

String _ensureFavoritesList() {
  const favoritePlaceListName = 'Favorites';
  final box = Hive.box<PlaceList>('placeLists');
  PlaceList favorites =
      box.values.firstWhere((c) => c.name == favoritePlaceListName, orElse: () {
    final newFav =
        PlaceList(id: const Uuid().v4(), name: favoritePlaceListName);
    box.put(newFav.id, newFav);
    return newFav;
  });
  return favorites.id;
}

class MyApp extends StatelessWidget {
  final String favoriteListId;

  const MyApp({super.key, required this.favoriteListId});

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
        child: AppRouter(
          favoriteListId: favoriteListId,
        ));
  }
}
