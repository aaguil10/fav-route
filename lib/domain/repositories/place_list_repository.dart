import 'package:fav_route/data/models/place_list_model.dart';

abstract class PlaceListRepository {
  void createPlaceList(PlaceList placeList);

  List<PlaceList> getAllPlaceLists();

  PlaceList getPlaceList(String id);

  void deletePlaceList(String id);
}
