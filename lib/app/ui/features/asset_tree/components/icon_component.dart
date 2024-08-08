import 'package:flutter/cupertino.dart';
import 'package:tractian_test/app/domain/entities/asset.dart';
import 'package:tractian_test/app/domain/entities/displayable_asset.dart';
import 'package:tractian_test/app/domain/entities/location.dart';

class IconComponent extends StatelessWidget {
  final DisplayableEntity data;

  const IconComponent({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (data is LocationEntity) {
      return Image.asset('assets/icons/location_icon.png');
    }
    if (data is AssetEntity && (data as AssetEntity).status != null) {
      return Image.asset('assets/icons/component_icon.png');
    }
    return Image.asset('assets/icons/asset_icon.png');
  }
}
