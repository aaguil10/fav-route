import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:fav_route/ui/blocs/place_list_bloc/place_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceRepository _repository;

  PlaceListBloc(this._repository) : super(PlacesLoading()) {
    on<LoadPlaceList>((event, emit) {
      final places = _repository.getPlaces();
      emit(PlacesLoaded(places));
    });

    on<AddPlaceList>((event, emit) {
      _repository.addPlace(event.place);
      add(LoadPlaceList());
    });

    on<UpdatePlaceList>((event, emit) {
      _repository.updatePlace(event.place);
      add(LoadPlaceList());
    });
  }
}
