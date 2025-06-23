import 'package:hive/hive.dart';

part 'place_list_model.g.dart';

@HiveType(typeId: 1)
class PlaceList extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  PlaceList({required this.id, required this.name});
}
