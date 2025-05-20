import 'package:equatable/equatable.dart';
import 'package:fav_route/models/place.dart';

class PlaceState extends Equatable {
  final List<Place> places;

  const PlaceState({this.places = const []});

  PlaceState copyWith({List<Place>? places}) =>
      PlaceState(places: places ?? this.places);

  @override
  List<Object?> get props => [places];
}
