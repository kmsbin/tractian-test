import 'package:flutter/material.dart';
import 'package:tractian_test/app/domain/entities/asset.dart';
import 'package:tractian_test/app/domain/entities/displayable_asset.dart';

import 'asset_status_component.dart';
import 'icon_component.dart';

class AssetTreeTileComponent extends StatelessWidget {
  final DisplayableEntity data;
  final EdgeInsets? padding;
  final bool showVerticaLine;
  static const _lineWidth = 2.0;
  static const _leadingWidth = 25.0;

  const AssetTreeTileComponent({
    required this.data,
    this.padding,
    this.showVerticaLine = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        shape: const Border(),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconComponent(data: data),
            const SizedBox(width: 8),
            Flexible(child: Text(data.name)),
            const SizedBox(width: 8),
            if (data is AssetEntity && (data as AssetEntity).status != null)
              AssetStatus(asset: data as AssetEntity)
          ],
        ),
        dense: true,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int index = 0; index < data.deepLevel; index++)
              Container(
                alignment: Alignment.center,
                width: _leadingWidth,
                child: Container(
                  width: _lineWidth,
                  color: Colors.grey,
                ),
              ),
            if (data.hasChildren)
              const SizedBox(
                width: _leadingWidth,
                child: Icon(Icons.keyboard_arrow_down_rounded),
              ),
          ],
        ),
        trailing: const SizedBox(),
      ),
    );
  }
}