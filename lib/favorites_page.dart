import 'package:fav_route/bloc/place_bloc.dart';
import 'package:fav_route/bloc/place_event.dart';
import 'package:fav_route/bloc/place_state.dart';
import 'package:fav_route/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_place_sheet.dart';

class FavoritesPage extends StatelessWidget {
  static const title = 'Favorites';

  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => PlaceBloc()..add(LoadPlaces()),
        child: BlocBuilder<PlaceBloc, PlaceState>(builder: (context, state) {
          if (state.places.isEmpty) {
            return Center(child: _buildAddButton(context));
          }
          return Column(
            children: [
              Expanded(child: _buildPlaceList(state.places)),
              _buildAddButton(context),
            ],
          );
        }));
  }

  Widget _buildPlaceList(List<Place> places) {
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(places[index].name ?? ''),
          subtitle: Text(places[index].address ?? ''),
        );
      },
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () async {
        final placeStr = await AddPlaceSheet.showAddPlaceSheet(context);
        final place = Place.fromJsonString(placeStr);
        context.read<PlaceBloc>().add(AddPlace(place));
      },
    );
  }
}
