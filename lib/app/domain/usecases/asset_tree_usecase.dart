import 'dart:collection';
import 'dart:developer';
import 'dart:isolate';

import 'package:dart_code_metrics_annotations/annotations.dart';
import 'package:tractian_test/app/domain/entities/asset.dart';
import 'package:tractian_test/app/domain/entities/displayable_asset.dart';
import 'package:tractian_test/app/domain/entities/location.dart';
import 'package:tractian_test/app/domain/exceptions/failed_get_assets_tree.dart';
import 'package:tractian_test/app/domain/repositories/asset_tree_repository.dart';

final class AssetTreeUseCase {
  final AssetTreeRepository repository;

  const AssetTreeUseCase(this.repository);

  @Throws({FailedGetAssetsTree})
  Future<List<DisplayableEntity>> getOrdenatedAssets(String companyID) async {
    try {
      final locations = await repository.getLocationByCompanyID(companyID);
      final assets = await repository.getAssetByCompanyID(companyID);
      return Isolate.run(() => _itemsOrganizer(locations, assets));
    } catch (e, s) {
      log('Error trying to load locations and assets', error: e, stackTrace: s);
      throw const FailedGetAssetsTree('a unknown error happened');
    }
  }

  static List<DisplayableEntity> _itemsOrganizer(List<LocationEntity> locations, List<AssetEntity> assets) {
    final rootItens = <DisplayableEntity>[];
    final childrenItems = HashMap<String, List<DisplayableEntity>>();
    for (final location in locations) {
      if (location.parentId case final parentId?) {
        childrenItems[parentId] ??= [];
        childrenItems[parentId]?.add(location);
      } else {
        rootItens.add(location);
      }
    }
    for (final asset in assets) {
      if (asset.locationId ?? asset.parentId case final parentId?) {
        childrenItems[parentId] ??= [];
        childrenItems[parentId]?.add(asset);
      } else {
        rootItens.add(asset);
      }
    }
    _iterateChildrenValuesInRootItems(rootItens, childrenItems);
    return rootItens;
  }

  static void _iterateChildrenValuesInRootItems(List<DisplayableEntity> items, HashMap<String, List<DisplayableEntity>> childrenValues) {
    for (int i = 0; i < items.length; i++) {
      if (childrenValues[items[i].id] case final children?) {
        for (var it in children) {
          it.deepLevel = items[i].deepLevel+1;
        }
        items[i].hasChildren = true;
        items.insertAll(i+1, children);
      }
    }
  }

  List<DisplayableEntity> filterList(List<DisplayableEntity> items, FilterData filterData) {

    final filteredState = <String, DisplayableEntity>{};
    final parentList = <String, DisplayableEntity>{};
    for (final item in items) {
      final lastParent = parentList.values.lastOrNull;
      parentList.removeWhere((k, v) => v.deepLevel >= item.deepLevel);

      if (_isOnFilter(item, filterData)) {
        filteredState.addAll(parentList);
        parentList[item.id] = item;
        filteredState[item.id] = item;
      } else if (lastParent == null || item.deepLevel >= lastParent.deepLevel) {
        parentList[item.id] = item;
      } else if (item.getParent() != lastParent.getParent()) {
        parentList[item.id] = item;
      }
    }
    return filteredState.values.toList();
  }

  static bool _isOnFilter(DisplayableEntity item, FilterData filter) {
    bool isOn = item.name.toLowerCase().contains(filter.text);
    if (filter.critical) {
      isOn = isOn && (item is AssetEntity && item.status == 'alert');
    }
    if (filter.energy) {
      isOn = isOn && (item is AssetEntity && item.sensorType == 'energy');
    }
    return isOn;
  }
}

typedef FilterData = ({
  String text,
  bool critical,
  bool energy,
});