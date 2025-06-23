import 'package:fav_route/domain/repositories/place_list_repository.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final String placeListId;
  final PlaceRepository placeRepository;
  final PlaceListRepository placeListRepository;

  PlaceBloc(
      {required this.placeListId,
      required this.placeRepository,
      required this.placeListRepository})
      : super(const PlacesInitial()) {
    on<LoadPlace>((event, emit) {
      emit(const PlacesLoading(placeList: null));
      final placeList = placeListRepository.getPlaceList(event.placeList.id);
      emit(PlacesLoading(placeList: placeList));
      final places = placeRepository.getPlaces(event.placeList.id);
      emit(PlacesLoaded(placeList: placeList, places: places));
    });

    on<AddPlace>((event, emit) {
      placeRepository.addPlace(event.place);
      final placeList = placeListRepository.getPlaceList(event.placeList.id);
      add(LoadPlace(placeList: placeList));
    });

    on<UpdatePlace>((event, emit) {
      placeRepository.updatePlace(event.place);
      final placeList = placeListRepository.getPlaceList(event.placeList.id);
      add(LoadPlace(placeList: placeList));
    });
  }
}
