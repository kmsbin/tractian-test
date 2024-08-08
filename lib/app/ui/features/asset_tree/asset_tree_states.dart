import 'package:tractian_test/app/domain/entities/displayable_asset.dart';
import 'package:tractian_test/app/domain/usecases/asset_tree_usecase.dart';

sealed class AssetsTreeState {
  const AssetsTreeState();
}
final class EmptyAssetsTreeState extends AssetsTreeState {
  const EmptyAssetsTreeState();
}

final class LoadingAssetsTreeState extends AssetsTreeState {
  const LoadingAssetsTreeState();
}

final class FilledAssetsTreeState extends AssetsTreeState {
  final List<DisplayableEntity> items;
  final List<DisplayableEntity>? filteredItems;
  final FilterData filterData;

  const FilledAssetsTreeState(this.items, {this.filteredItems, required this.filterData});

  List<DisplayableEntity> getItems() => filteredItems ?? items;
}

final class FailedAssetsTreeState extends AssetsTreeState {
  final String message;
  const FailedAssetsTreeState(this.message);
}
