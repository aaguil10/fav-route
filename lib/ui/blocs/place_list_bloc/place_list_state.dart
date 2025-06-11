import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place.dart';

abstract class PlaceListState extends Equatable {
  const PlaceListState();
}

class PlacesLoading extends PlaceListState {
  @override
  List<Object?> get props => [];
}

class PlacesLoaded extends PlaceListState {
  final List<Place> places;

  const PlacesLoaded(this.places);

  @override
  List<Object?> get props => [places];
}
