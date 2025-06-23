import 'package:equatable/equatable.dart';
import 'package:fav_route/data/models/place_list_model.dart';

abstract class SavedPlacesState extends Equatable {
  const SavedPlacesState();

  @override
  List<Object?> get props => [];
}

class SavedPlacesInitial extends SavedPlacesState {}

class SavedPlacesLoading extends SavedPlacesState {}

class SavedPlacesLoaded extends SavedPlacesState {
  final List<PlaceList> placeList;

  const SavedPlacesLoaded(this.placeList);

  @override
  List<Object?> get props => [placeList];
}

class SavedPlacesError extends SavedPlacesState {
  final String message;

  const SavedPlacesError(this.message);

  @override
  List<Object?> get props => [message];
}
