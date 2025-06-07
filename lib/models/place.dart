import 'dart:convert';

import 'package:hive/hive.dart';

part 'place.g.dart';

@HiveType(typeId: 0)
class Place {
  @HiveField(0)
  int id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String address;
  @HiveField(3)
  String? note;

  Place({required this.id, this.name, required this.address, this.note});

  Place copyWith({String? name, String? address, String? note}) => Place(
      id: id,
      name: name ?? this.name,
      address: address ?? this.address,
      note: note ?? this.note);

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'] as int,
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
