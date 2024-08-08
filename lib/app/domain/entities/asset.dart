import 'displayable_asset.dart';

class AssetEntity implements DisplayableEntity {
  @override
  final String id;
  @override
  final String name;
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;
  @override
  int deepLevel;
  @override
  bool hasChildren;

  AssetEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
    this.deepLevel = 0,
    this.hasChildren = false,
  });

  @override
  String? getParent() => locationId ?? parentId;
}
