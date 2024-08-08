import 'package:bloc/bloc.dart';
import 'package:tractian_test/app/domain/exceptions/failed_get_assets_tree.dart';
import 'package:tractian_test/app/domain/repositories/asset_tree_repository.dart';
import 'package:tractian_test/app/domain/usecases/asset_tree_usecase.dart';
import 'package:tractian_test/injectors/injector.dart';

import 'asset_tree_events.dart';
import 'asset_tree_states.dart';

class AssetsTreeBloc extends Bloc<AssetsTreeEvent, AssetsTreeState> {
  final assetTreeUseCase = AssetTreeUseCase(getIt.get<AssetTreeRepository>());

  AssetsTreeBloc([super.initialState = const EmptyAssetsTreeState()]) {
    on(getAllAssetsTree);
    on(filterAssets);
  }

  Future<void> getAllAssetsTree(FetchAssetsTreeEvent event, Emitter<AssetsTreeState> emit) async {
    try {
      emit(const LoadingAssetsTreeState());
      final assets = await assetTreeUseCase.getOrdenatedAssets(event.companyId);
      emit(
        FilledAssetsTreeState(
          assets,
          filterData: (
            energy: false,
            critical: false,
            text: '',
          )
        ),
      );
    } on FailedGetAssetsTree catch (e) {
      emit(FailedAssetsTreeState(e.message));
    }
  }

  Future<void> filterAssets(FilterAssetsTreeEvent event, Emitter<AssetsTreeState> emit) async {
    final state = this.state;
    if (state is !FilledAssetsTreeState) return;
    emit(const LoadingAssetsTreeState());
    emit(FilledAssetsTreeState(
      state.items,
      filteredItems:  assetTreeUseCase.filterList(state.items, event.filterToTuple()),
      filterData: event.filterToTuple()
    ));
  }
}
