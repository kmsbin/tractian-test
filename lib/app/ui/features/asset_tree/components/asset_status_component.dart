import 'package:flutter/material.dart';
import 'package:tractian_test/app/domain/entities/asset.dart';

class AssetStatus extends StatelessWidget {
  final AssetEntity asset;
  const AssetStatus({required this.asset, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      switch(asset.sensorType) {
        'energy' => Icons.flash_on,
        _ => Icons.circle,
      },
      color: switch(asset.status) {
        'operating' => Colors.green,
        _ => Colors.red,
      },
      size: 15,
    );
  }
}