// lib/bloc/place_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'place_event.dart';
import 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  PlaceBloc() : super(const PlaceState()) {
    on<LoadPlaces>((event, emit) {
      // load from hive
      emit(const PlaceState());
    });

    on<AddPlace>((event, emit) {
      final updated = List.of(state.places)..add(event.place);
      emit(state.copyWith(places: updated));
    });

    on<UpdatePlace>((event, emit) {
      final updated = state.places.map((p) {
        return p.id == event.place.id ? event.place : p;
      }).toList();
      emit(state.copyWith(places: updated));
    });
  }
}
