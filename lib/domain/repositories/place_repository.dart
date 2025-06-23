import 'package:fav_route/data/models/place_model.dart';

abstract class PlaceRepository {
  List<Place> getPlaces(String placeListId);

  void addPlace(final Place place);

  Future<void> removePlace(final Place place);

  Future<void> updatePlace(final Place place);
}
