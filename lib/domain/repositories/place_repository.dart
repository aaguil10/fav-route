import 'package:fav_route/data/models/place.dart';

abstract class PlaceRepository {
  List<Place> getPlaces();

  void addPlace(final Place place);

  Future<void> removePlace(final Place place);

  Future<void> updatePlace(final Place place);
}
