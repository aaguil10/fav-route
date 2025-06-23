import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/data/models/place_model.dart';

/// Events for [PlaceBloc]: loading, adding, and updating places.
abstract class PlaceEvent extends Equatable {
  final PlaceList placeList;

  const PlaceEvent({required this.placeList});

  @override
  List<Object?> get props => [placeList];
}

/// Load all places for the given list.
class LoadPlace extends PlaceEvent {
  const LoadPlace({required PlaceList placeList}) : super(placeList: placeList);
}

/// Add a new [place] to the given list, then reload.
class AddPlace extends PlaceEvent {
  final Place place;

  const AddPlace({required PlaceList placeList, required this.place})
      : super(placeList: placeList);

  @override
  List<Object?> get props => [placeList, place];
}

/// Update an existing [place] in the given list, then reload.
class UpdatePlace extends PlaceEvent {
  final Place place;

  const UpdatePlace({required PlaceList placeList, required this.place})
      : super(placeList: placeList);

  @override
  List<Object?> get props => [placeList, place];
}
