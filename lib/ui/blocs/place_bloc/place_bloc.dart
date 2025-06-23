import 'package:fav_route/data/models/place_list_model.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceList? placeList;
  final PlaceRepository repository;

  PlaceBloc({this.placeList, required this.repository})
      : super(const PlacesInitial()) {
    on<LoadPlace>((event, emit) {
      final places = repository.getPlaces(event.placeList.id);
      emit(PlacesLoaded(placeList: placeList, places: places));
    });

    on<AddPlace>((event, emit) {
      repository.addPlace(event.place);
      add(LoadPlace(placeList: placeList!));
    });

    on<UpdatePlace>((event, emit) {
      repository.updatePlace(event.place);
      add(LoadPlace(placeList: placeList!));
    });
  }
}
