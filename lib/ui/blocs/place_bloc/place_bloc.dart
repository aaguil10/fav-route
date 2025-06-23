import 'package:fav_route/domain/repositories/place_list_repository.dart';
import 'package:fav_route/domain/repositories/place_repository.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_event.dart';
import 'package:fav_route/ui/blocs/place_bloc/place_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlaceRepository _placeRepository;
  final PlaceListRepository _placeListRepository;

  PlaceBloc({
    required PlaceRepository placeRepository,
    required PlaceListRepository placeListRepository,
  })  : _placeRepository = placeRepository,
        _placeListRepository = placeListRepository,
        super(const PlacesInitial()) {
    on<LoadPlace>(_onLoadPlace);
    on<AddPlace>(_onAddPlace);
    on<UpdatePlace>(_onUpdatePlace);
  }

  Future<void> _onLoadPlace(
    LoadPlace event,
    Emitter<PlaceState> emit,
  ) async {
    emit(PlacesLoading(placeList: event.placeList));

    final freshList = _placeListRepository.getPlaceList(event.placeList.id);
    final places = _placeRepository.getPlaces(event.placeList.id);

    emit(PlacesLoaded(placeList: freshList, places: places));
  }

  Future<void> _onAddPlace(
    AddPlace event,
    Emitter<PlaceState> emit,
  ) async {
    _placeRepository.addPlace(event.place);
    add(LoadPlace(placeList: event.placeList));
  }

  Future<void> _onUpdatePlace(
    UpdatePlace event,
    Emitter<PlaceState> emit,
  ) async {
    await _placeRepository.updatePlace(event.place);
    add(LoadPlace(placeList: event.placeList));
  }
}
