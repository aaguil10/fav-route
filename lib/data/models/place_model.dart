import 'dart:convert';

import 'package:hive/hive.dart';

part 'place_model.g.dart';

@HiveType(typeId: 0)
class Place extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String address;
  @HiveField(3)
  final String? note;
  @HiveField(4)
  final List<String> placeListIds;

  Place(
      {required this.id,
      required this.placeListIds,
      this.name,
      required this.address,
      this.note});

  Place copyWith(
          {String? name,
          String? address,
          String? note,
          List<String>? placeListId}) =>
      Place(
          id: this.id,
          placeListIds: placeListId ?? this.placeListIds,
          name: name ?? this.name,
          address: address ?? this.address,
          note: note ?? this.note);

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as String,
      placeListIds: json['placeListId'] as List<String>,
      name: json['name'] as String?,
      address: json['address'] as String,
      note: json['note'] as String?,
    );
  }

  factory Place.fromJsonString(String jsonStr) {
    final decoded = jsonDecode(jsonStr);
    return Place.fromJson(decoded);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'placeListIds': placeListIds,
      'name': name,
      'address': address,
      'note': note,
    };
  }

  @override
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
