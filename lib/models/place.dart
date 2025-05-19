import 'dart:convert';

class Place {
  int id;
  String? name;
  String address;
  String? note;

  Place({required this.id, this.name, required this.address, this.note});

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
