import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/data/models/place_model.dart';

abstract class PlaceState extends Equatable {
  final PlaceList? placeList;

  const PlaceState({this.placeList});
}

class PlacesInitial extends PlaceState {
  const PlacesInitial({super.placeList});

  @override
  List<Object?> get props => [placeList];
}

class PlacesLoading extends PlaceState {
  const PlacesLoading({required super.placeList});

  @override
  List<Object?> get props => [placeList];
}

class PlacesLoaded extends PlaceState {
  final List<Place> places;

  const PlacesLoaded({required super.placeList, required this.places});

  @override
  List<Object?> get props => [placeList, places];
}
