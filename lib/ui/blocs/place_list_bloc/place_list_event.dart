import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place.dart';

abstract class PlaceListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPlaceList extends PlaceListEvent {}

class AddPlaceList extends PlaceListEvent {
  final Place place;

  AddPlaceList(this.place);

  @override
  List<Object?> get props => [place];
}

class UpdatePlaceList extends PlaceListEvent {
  final Place place;

  UpdatePlaceList(this.place) {}

  @override
  List<Object?> get props => [place];
}
