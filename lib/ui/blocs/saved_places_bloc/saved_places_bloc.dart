import 'package:fav_route/domain/repositories/place_list_repository.dart';
import 'package:fav_route/ui/blocs/saved_places_bloc/saved_places_event.dart';
import 'package:fav_route/ui/blocs/saved_places_bloc/saved_places_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedPlacesBloc extends Bloc<SavedPlacesEvent, SavedPlacesState> {
  final PlaceListRepository _repository;

  SavedPlacesBloc(this._repository) : super(SavedPlacesInitial()) {
    on<LoadSavedPlaces>(_onLoadSavedPlaces);
    on<AddPlaceList>(_onAddPlaceList);
    on<DeletePlaceList>(_onDeletePlaceList);
  }

  Future<void> _onLoadSavedPlaces(
      LoadSavedPlaces event, Emitter<SavedPlacesState> emit) async {
    emit(SavedPlacesLoading());
    try {
      final placeLists = _repository.getAllPlaceLists();
      emit(SavedPlacesLoaded(placeLists));
    } catch (_) {
      emit(const SavedPlacesError('Failed to load lists'));
    }
  }

  Future<void> _onAddPlaceList(
      AddPlaceList event, Emitter<SavedPlacesState> emit) async {
    try {
      _repository.createPlaceList(event.placeList);
      add(LoadSavedPlaces());
    } catch (_) {
      emit(const SavedPlacesError('Failed to create list'));
    }
  }

  Future<void> _onDeletePlaceList(
      DeletePlaceList event, Emitter<SavedPlacesState> emit) async {
    try {
      _repository.deletePlaceList(event.placeListId);
      add(LoadSavedPlaces());
    } catch (_) {
      emit(const SavedPlacesError('Failed to delete list'));
    }
  }
}
