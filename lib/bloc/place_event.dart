import 'package:equatable/equatable.dart';
import 'package:fav_route/models/place.dart';

abstract class PlaceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPlaces extends PlaceEvent {}

class AddPlace extends PlaceEvent {
  final Place place;

  AddPlace(this.place);

  @override
  List<Object?> get props => [place];
}

class UpdatePlace extends PlaceEvent {
  final Place place;

  UpdatePlace(this.place) {}

  @override
  List<Object?> get props => [place];
}
