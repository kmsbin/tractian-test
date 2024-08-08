import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_test/app/ui/shared/design_system_spacing.dart';
import 'asset_tree_bloc.dart';
import 'asset_tree_events.dart';
import 'asset_tree_states.dart';

import 'components/asset_tree_tile_component.dart';

class AssetsTreePerformaticView extends StatefulWidget {
  final String companyId;

  const AssetsTreePerformaticView({
    required this.companyId,
    super.key,
  });

  @override
  State<AssetsTreePerformaticView> createState() => _AssetsTreePerformaticViewState();
}

class _AssetsTreePerformaticViewState extends State<AssetsTreePerformaticView> {
  final locationsAndAssetsBloc = AssetsTreeBloc();

  @override
  void initState() {
    super.initState();
    locationsAndAssetsBloc.add(FetchAssetsTreeEvent(widget.companyId));
  }

  @override
  void dispose() {
    locationsAndAssetsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dados da companhia'),
      ),
      body: BlocBuilder<AssetsTreeBloc, AssetsTreeState>(
        bloc: locationsAndAssetsBloc,
        builder: (context, state) {
          if (state is LoadingAssetsTreeState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is FailedAssetsTreeState) {
            return const Center(
              child: Text('Aconteceu algum proble tente novamente mais tarde :('),
            );
          }
          if (state is! FilledAssetsTreeState) {
            return const Center(
              child: Text('Nenhum asset encontrado'),
            );
          }
          final items = state.getItems();
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(DesignSystemSpacing(2).getSize()),
                child: TextFormField(
                  onChanged: (text) {
                    locationsAndAssetsBloc.add(FilterAssetsTreeEvent(text: text));
                  },
                  onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: const InputDecoration(
                    // fillColor: Colors.pink,
                    hintText: 'Buscar Ativo ou Local'
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(DesignSystemSpacing(2).getSize()),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: state.filterData.energy ? const Color(0xff1c6fff) : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () => locationsAndAssetsBloc.add(
                          FilterAssetsTreeEvent(
                            text: state.filterData.text,
                            energy: !state.filterData.energy,
                            critical: state.filterData.critical,
                          ),
                        ),
                        child: const Text(
                          'Sensor de energia',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(width: DesignSystemSpacing(2).getSize(),),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: state.filterData.critical ? const Color(0xff1c6fff) : Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        onPressed: () {
                          locationsAndAssetsBloc.add(
                            FilterAssetsTreeEvent(
                              text: state.filterData.text,
                              energy: state.filterData.energy,
                              critical: !state.filterData.critical,
                            ),
                          );
                        },
                        child: const Text(
                          'Crítico',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Divider(color: Colors.grey, height: 1,),
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(DesignSystemSpacing(2).getSize()),
                  itemCount: items.length,
                  shrinkWrap: false,
                  addRepaintBoundaries: false,
                  addAutomaticKeepAlives: false,
                  addSemanticIndexes: false,
                  itemBuilder: (_, index) {
                    final item = items.elementAt(index);
                    return AssetTreeTileComponent(
                      key: Key('asset_item_${item.id}'),
                      data: item,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}


