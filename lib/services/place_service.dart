import 'package:fav_route/models/place.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlaceService {
  final Box<Place> _places;

  PlaceService() : _places = Hive.box<Place>('places');

  @visibleForTesting
  PlaceService.test({required Box<Place> box}) : _places = box;

  List<Place> getPlaces() => _places.values.toList();

  // Todo: Block duplicates.
  void addPlace(final Place place) => _places.add(place);

  Future<void> removePlace(final Place place) => _places.delete(place.id);

  Future<void> updatePlace(final Place place) async {
    _places.put(
        place.id,
        place.copyWith(
            name: place.name, address: place.address, note: place.note));
  }
}
