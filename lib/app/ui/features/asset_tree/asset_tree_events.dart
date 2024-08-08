import 'package:tractian_test/app/domain/usecases/asset_tree_usecase.dart';

sealed class AssetsTreeEvent {
  const AssetsTreeEvent();
}

final class FetchAssetsTreeEvent extends AssetsTreeEvent {
  final String companyId;
  const FetchAssetsTreeEvent(this.companyId);
}

final class FilterAssetsTreeEvent extends AssetsTreeEvent {
  final String text;
  final bool critical;
  final bool energy;

  const FilterAssetsTreeEvent({this.text = '', this.critical = false, this.energy = false});

  FilterData filterToTuple() {
    return (
      critical: critical,
      energy: energy,
      text: text,
    );
  }
}
