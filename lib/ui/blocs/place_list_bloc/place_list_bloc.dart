import 'package:fav_route/data/repositories/place_service.dart';
import 'package:fav_route/ui/blocs/place_list_bloc/place_list_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_list_state.dart';

class PlaceListBloc extends Bloc<PlaceListEvent, PlaceListState> {
  final PlaceService _placeService;

  PlaceListBloc(this._placeService) : super(PlacesLoading()) {
    on<LoadPlaceList>((event, emit) {
      final places = _placeService.getPlaces();
      emit(PlacesLoaded(places));
    });

    on<AddPlaceList>((event, emit) {
      _placeService.addPlace(event.place);
      add(LoadPlaceList());
    });

    on<UpdatePlaceList>((event, emit) {
      _placeService.updatePlace(event.place);
      add(LoadPlaceList());
    });
  }
}
