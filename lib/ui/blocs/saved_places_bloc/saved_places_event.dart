import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place_list_model.dart';

abstract class SavedPlacesEvent extends Equatable {
  const SavedPlacesEvent();

  @override
  List<Object?> get props => [];
}

class LoadSavedPlaces extends SavedPlacesEvent {}

class AddPlaceList extends SavedPlacesEvent {
  final PlaceList placeList;

  const AddPlaceList(this.placeList);

  @override
  List<Object?> get props => [placeList];
}

class DeletePlaceList extends SavedPlacesEvent {
  final String placeListId;

  const DeletePlaceList(this.placeListId);

  @override
  List<Object?> get props => [placeListId];
}
