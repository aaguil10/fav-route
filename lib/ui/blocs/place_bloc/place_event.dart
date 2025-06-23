import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/data/models/place_model.dart';

abstract class PlaceEvent extends Equatable {
  final PlaceList placeList;

  const PlaceEvent({required this.placeList});

  @override
  List<Object?> get props => [placeList];
}

class LoadPlace extends PlaceEvent {
  const LoadPlace({required super.placeList});

  @override
  List<Object?> get props => [placeList];
}

class AddPlace extends PlaceEvent {
  final Place place;

  const AddPlace({required super.placeList, required this.place});

  @override
  List<Object?> get props => [place];
}

class UpdatePlace extends PlaceEvent {
  final Place place;

  const UpdatePlace({required super.placeList, required this.place});

  @override
  List<Object?> get props => [place];
}
