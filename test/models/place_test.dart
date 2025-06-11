import 'package:fav_route/data/models/place.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Place', () {
    test('constructor assigns values correctly', () {
      final place =
          Place(id: 1, name: 'Home', address: '123 Main St', note: 'Favorite');
      expect(place.id, 1);
      expect(place.name, 'Home');
      expect(place.address, '123 Main St');
      expect(place.note, 'Favorite');
    });

    test('toJson and fromJson create identical Place', () {
      final place =
          Place(id: 2, name: 'Work', address: '456 Market St', note: null);
      final json = place.toJson();
      final fromJson = Place.fromJson(json);
      expect(fromJson.id, place.id);
      expect(fromJson.name, place.name);
      expect(fromJson.address, place.address);
      expect(fromJson.note, place.note);
    });

    test('toJsonString and fromJsonString round trip', () {
      final original =
          Place(id: 3, name: null, address: '789 Park Ave', note: 'Quiet');
      final jsonStr = original.toJsonString();
      final recreated = Place.fromJsonString(jsonStr);
      expect(recreated.id, original.id);
      expect(recreated.name, original.name);
      expect(recreated.address, original.address);
      expect(recreated.note, original.note);
    });

    test('handles null optional fields', () {
      final place = Place(id: 4, address: '101 Ocean Dr');
      final json = place.toJson();
      expect(json['name'], null);
      expect(json['note'], null);

      final fromJson = Place.fromJson(json);
      expect(fromJson.name, null);
      expect(fromJson.note, null);
    });
  });
}
