
import 'package:tractian_test/app/domain/entities/displayable_asset.dart';

class LocationEntity implements DisplayableEntity {
  @override
  final String id;
  @override
  final String name;
  final String? parentId;
  @override
  int deepLevel;
  @override
  bool hasChildren;

  LocationEntity({
    required this.id,
    required this.name,
    this.parentId,
    this.deepLevel = 0,
    this.hasChildren = false,
  });

  @override
  String? getParent() => parentId;
}