import 'package:fav_route/data/models/place_model.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlaceRepositoryImpl extends PlaceRepository {
  final Box<Place> _places;

  PlaceRepositoryImpl() : _places = Hive.box<Place>('places');

  @visibleForTesting
  PlaceRepositoryImpl.test({required Box<Place> box}) : _places = box;

  @override
  List<Place> getPlaces(String placeListId) => _places.values
      .where((place) => place.placeListIds.contains(placeListId))
      .toList();

  // Todo: Block duplicates.
  @override
  void addPlace(final Place place) => _places.add(place);

  @override
  Future<void> removePlace(final Place place) => _places.delete(place.id);

  @override
  Future<void> updatePlace(final Place place) async {
    _places.put(
        place.id,
        place.copyWith(
            name: place.name, address: place.address, note: place.note));
  }
}
