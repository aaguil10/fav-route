import 'package:fav_route/services/place_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_event.dart';
import 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceService _placeService;

  PlaceBloc(this._placeService) : super(PlacesLoading()) {
    on<LoadPlaces>((event, emit) {
      final places = _placeService.getPlaces();
      emit(PlacesLoaded(places));
    });

    on<AddPlace>((event, emit) {
      _placeService.addPlace(event.place);
      add(LoadPlaces());
    });

    on<UpdatePlace>((event, emit) {
      _placeService.updatePlace(event.place);
      add(LoadPlaces());
    });
  }
}
