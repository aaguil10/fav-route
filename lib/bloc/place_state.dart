import 'package:equatable/equatable.dart';
import 'package:fav_route/models/place.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();
}

class PlacesLoading extends PlaceState {
  @override
  List<Object?> get props => [];
}

class PlacesLoaded extends PlaceState {
  final List<Place> places;

  const PlacesLoaded(this.places);

  @override
  List<Object?> get props => [places];
}
