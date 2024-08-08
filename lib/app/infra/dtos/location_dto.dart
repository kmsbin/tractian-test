import '../../domain/entities/location.dart';

class LocationDto {
  final String id;
  final String name;
  final String? parentId;
  int deepLevel;

  LocationDto({
    required this.id,
    required this.name,
    required this.parentId,
    this.deepLevel = 0,
  });

  factory LocationDto.fromMap(Map<String, dynamic> jsonMap) {
    return LocationDto(
      id: jsonMap['id'],
      name: jsonMap['name'],
      parentId: jsonMap['parentId'],
    );
  }

  static List<LocationEntity> fromListMapToEntity(List jsonsMaps) {
    return jsonsMaps
        .map((it) => LocationDto.fromMap((it as Map).cast()).toEntity())
        .toList();
  }

  LocationEntity toEntity() {
    return LocationEntity(
      id: id,
      name: name,
      parentId: parentId,
    );
  }

  @override
  String toString() {
    return 'LocationDto(\n'
        '  id: $id, \n'
        '  name: $name,\n'
        '),\n';
  }
}