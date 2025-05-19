import 'package:fav_route/models/place.dart';
import 'package:flutter/material.dart';

import 'add_place_sheet.dart';

class FavoritesPage extends StatefulWidget {
  static const title = 'Favorites';

  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<Place> places = [];

  @override
  Widget build(BuildContext context) {
    return places.isEmpty
        ? Center(
            child: _buildAddButton(),
          )
        : Column(
            children: [
              Expanded(child: _buildPlaceList()),
              _buildAddButton(),
            ],
          );
  }

  Widget _buildPlaceList() {
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

  Widget _buildAddButton() {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () async {
        final placeStr = await AddPlaceSheet.showAddPlaceSheet(context);
        setState(() {
          places.add(Place.fromJsonString(placeStr));
        });
      },
    );
  }
}
