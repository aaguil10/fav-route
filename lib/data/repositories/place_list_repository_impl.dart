import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/domain/repositories/place_list_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class PlaceListRepositoryImpl extends PlaceListRepository {
  final Box<PlaceList> _placeLists;

  PlaceListRepositoryImpl() : _placeLists = Hive.box<PlaceList>('placeLists');

  @visibleForTesting
  PlaceListRepositoryImpl.test({required Box<PlaceList> box})
      : _placeLists = box;

  @override
  void createPlaceList(PlaceList placeList) {
    _placeLists.add(placeList);
  }

  @override
  void deletePlaceList(String id) => _placeLists.delete(id);

  @override
  List<PlaceList> getAllPlaceLists() {
    return _placeLists.values.toList();
  }
}
