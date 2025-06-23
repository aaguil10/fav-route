import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/data/models/place_model.dart';

abstract class PlaceState extends Equatable {
  final PlaceList? placeList;

  const PlaceState({this.placeList});

  @override
  List<Object?> get props => [placeList];
}

class PlacesInitial extends PlaceState {
  const PlacesInitial() : super();
}

class PlacesLoading extends PlaceState {
  const PlacesLoading({required PlaceList placeList})
      : super(placeList: placeList);
}

class PlacesLoaded extends PlaceState {
  final List<Place> places;

  const PlacesLoaded({required PlaceList placeList, required this.places})
      : super(placeList: placeList);

  @override
  List<Object?> get props => [placeList, places];
}
