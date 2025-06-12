import 'package:fav_route/data/models/place.dart';
import 'package:fav_route/data/repositories/place_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks.mocks.dart';

void main() {
  late MockBox<Place> mockBox;
  late PlaceRepositoryImpl placeService;

  setUp(() {
    mockBox = MockBox<Place>();
    placeService = PlaceRepositoryImpl.test(box: mockBox);
  });

  test('getPlaces returns all places from the box', () {
    final places = [
      Place(id: 1, name: 'Test 1', address: '', note: ''),
      Place(id: 2, name: 'Test 2', address: '', note: '')
    ];
    when(mockBox.values).thenReturn(places);

    final result = placeService.getPlaces();

    expect(result, equals(places));
    verify(mockBox.values).called(1);
  });

  test('addPlace adds place to the box', () {
    final place = Place(id: 123, name: 'Test Place', address: '', note: '');

    when(mockBox.add(any)).thenAnswer((_) async => 0);

    placeService.addPlace(place);

    verify(mockBox.add(place)).called(1);
  });

  test('removePlace deletes the place by id', () async {
    final place = Place(id: 321, name: 'To Delete', address: '', note: '');

    await placeService.removePlace(place);

    verify(mockBox.delete(321)).called(1);
  });

  test('updatePlace calls put with updated copy', () async {
    final place = Place(id: 456, name: 'Old', address: 'Addr', note: 'Note');

    await placeService.updatePlace(place);

    verify(mockBox.put(456, any)).called(1);
  });
}
