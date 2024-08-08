import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/services.dart';
import 'package:tractian_test/app/domain/entities/asset.dart';
import 'package:tractian_test/app/domain/entities/location.dart';
import 'package:tractian_test/app/domain/repositories/asset_tree_repository.dart';
import 'package:tractian_test/app/infra/dtos/asset_dto.dart';
import 'package:tractian_test/app/infra/dtos/location_dto.dart';

final class AssetTreeRepositoryImpl implements AssetTreeRepository {
  @override
  Future<List<LocationEntity>> getLocationByCompanyID(String companyID) async {
    final asset = await rootBundle.loadString('assets/data/$companyID/locations.json');
    return await Isolate.run(() async {
      final response = jsonDecode(asset);
      return LocationDto.fromListMapToEntity(response ?? []);
    });
  }

  @override
  Future<List<AssetEntity>> getAssetByCompanyID(String companyID) async {
    final asset = await rootBundle.loadString('assets/data/$companyID/assets.json');

    return await Isolate.run(() async {
      final response = jsonDecode(asset);
      return AssetDto.fromListMapToEntity(response ?? []);
    });
  }
}