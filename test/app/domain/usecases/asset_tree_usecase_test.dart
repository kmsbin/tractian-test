import 'package:test/test.dart';
import 'package:tractian_test/app/domain/usecases/asset_tree_usecase.dart';

import '../../infra/repositories/asset_tree_repository_mock.dart';

main() {
  test('Must retrieve and sort all locations and assets', () async {
    final repository = AssetTreeRepositoryMock();

    final orderIds = [
      (id: '1_loc', deepLevel: 0),
      (id: '2_asset', deepLevel: 1),
      (id: '3_asset', deepLevel: 1),
      (id: '1_asset', deepLevel: 0),
      (id: '4_asset', deepLevel: 1),
    ];
    final items = await AssetTreeUseCase(repository).getOrdenatedAssets('');
    for (int index = 0; index < orderIds.length; index++) {
      expect(items[index].id, orderIds[index].id);
      expect(items[index].deepLevel, orderIds[index].deepLevel);
    }
  });

  test('Must filter by name', () async {
    final repository = AssetTreeRepositoryMock();

    final orderIds = [
      (id: '1_loc', deepLevel: 0),
      (id: '2_asset', deepLevel: 1),
      (id: '1_asset', deepLevel: 0),
    ];
    final useCase = AssetTreeUseCase(repository);
    final items = await AssetTreeUseCase(repository).getOrdenatedAssets('');
    final filteredItems = useCase.filterList(items, (text: 'vibration', critical: false, energy: false));

    for (final (index, item) in filteredItems.indexed) {
      expect(orderIds[index].id, item.id);
      expect(orderIds[index].deepLevel, item.deepLevel);
    }

    expect(orderIds.length, filteredItems.length);
  });

  test('Must filter by critical status', () async {
    final repository = AssetTreeRepositoryMock();

    final orderIds = [
      (id: '1_loc', deepLevel: 0),
      (id: '2_asset', deepLevel: 1),
    ];
    final useCase = AssetTreeUseCase(repository);
    final items = await AssetTreeUseCase(repository).getOrdenatedAssets('');
    final filteredItems = useCase.filterList(items, (text: '', critical: true, energy: false));
    for (final (index, value) in filteredItems.indexed) {
      expect(items[index].id, value.id);
      expect(items[index].deepLevel, value.deepLevel);
    }
    expect(orderIds.length, filteredItems.length);
  });

  test('Must filter by energy type', () async {
    final repository = AssetTreeRepositoryMock();

    final orderIds = [
      (id: '1_asset', deepLevel: 0),
      (id: '4_asset', deepLevel: 1),
    ];
    final useCase = AssetTreeUseCase(repository);
    final items = await useCase.getOrdenatedAssets('');
    final filteredItems = useCase.filterList(items, (text: '', critical: false, energy: true));
    for (final (index, value) in filteredItems.indexed) {
      expect(orderIds[index].id, value.id);
      expect(orderIds[index].deepLevel, value.deepLevel);
    }
    expect(orderIds.length, filteredItems.length);
  });
}
