import 'package:tractian_test/app/domain/entities/asset.dart';
import 'package:tractian_test/app/domain/entities/location.dart';
import 'package:tractian_test/app/domain/repositories/asset_tree_repository.dart';

class AssetTreeRepositoryMock implements AssetTreeRepository {
  @override
  Future<List<AssetEntity>> getAssetByCompanyID(_) async {
    return [
      AssetEntity(id: '1_asset', name: 'vibration Machine with child'),
      AssetEntity(id: '2_asset', name: 'vibration Machine loc', locationId: '1_loc', status: 'alert'),
      AssetEntity(id: '3_asset', name: 'energy Machine', locationId: '1_loc'),
      AssetEntity(id: '4_asset', name: 'energy Machine2', parentId: '1_asset', sensorType: 'energy'),
    ];
  }

  @override
  Future<List<LocationEntity>> getLocationByCompanyID(_) async {
    return [
      LocationEntity(id: '1_loc', name: 'has 2 subItem'),
    ];
  }
}
