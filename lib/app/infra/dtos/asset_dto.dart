import 'package:tractian_test/app/domain/entities/asset.dart';

class AssetDto {
  final String id;
  final String? sensorId;
  final String name;
  final String? parentId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  AssetDto({
    required this.id,
    required this.name,
    required this.parentId,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    required this.locationId,
  });

  factory AssetDto.fromMap(Map<String, dynamic> jsonMap) {
    return AssetDto(
      id: jsonMap['id'],
      name: jsonMap['name'],
      parentId: jsonMap['parentId'],
      sensorId: jsonMap['sensorId'],
      sensorType: jsonMap['sensorType'],
      status: jsonMap['status'],
      gatewayId: jsonMap['gatewayId'],
      locationId: jsonMap['locationId'],
    );
  }

  static List<AssetEntity> fromListMapToEntity(List jsonsMaps) {
    return jsonsMaps
        .map((e) => AssetDto.fromMap((e as Map).cast()).toEntity())
        .toList();
  }

  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      name: name,
      parentId: parentId,
      sensorId: sensorId,
      sensorType: sensorType,
      status: status,
      gatewayId: gatewayId,
      locationId: locationId,
    );
  }

  @override
  String toString() {
    return 'AssetEntity(\n'
        '  id: $id,\n'
        '  name: $name,\n'
        '),\n';
  }
}
