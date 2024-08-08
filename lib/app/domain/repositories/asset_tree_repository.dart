import 'package:dart_code_metrics_annotations/annotations.dart';
import 'package:tractian_test/app/domain/entities/asset.dart';
import 'package:tractian_test/app/domain/entities/location.dart';
import 'package:tractian_test/app/domain/exceptions/failed_get_assets_tree.dart';

abstract interface class AssetTreeRepository {
  @Throws({FailedGetAssetsTree})
  Future<List<LocationEntity>> getLocationByCompanyID(String companyID);
  Future<List<AssetEntity>> getAssetByCompanyID(String companyID);
}