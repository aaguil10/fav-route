import 'package:fav_route/data/models/place.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class PlaceRepositoryImpl extends PlaceRepository {
  final Box<Place> _places;

  PlaceRepositoryImpl() : _places = Hive.box<Place>('places');

  @visibleForTesting
  PlaceRepositoryImpl.test({required Box<Place> box}) : _places = box;

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
