import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';

class CustomerRoomAssetsScreen extends StatelessWidget {
  const CustomerRoomAssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.roomView,
        context: context,
        canBack: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: Measurement.generalSize16.allPadding,
            child: Container(
              padding: Measurement.generalSize12.horizontalPadding +
                  Measurement.generalSize8.verticalPadding,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: AppColor.grey,
                    size: Measurement.generalSize20,
                  ),
                  SizedBox(width: Measurement.generalSize12),
                  Expanded(
                    child: Text(
                      AppString.searchAssets,
                      style: TextStyle(
                        color: AppColor.grey,
                        fontSize: Measurement.mediumFont,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Assets List
          Expanded(
            child: ListView.separated(
              padding: Measurement.generalSize16.horizontalPadding,
              itemCount: mockAssets.length,
              separatorBuilder: (_, __) => Measurement.generalSize8.height,
              itemBuilder: (context, index) {
                final asset = mockAssets[index];
                return _AssetItem(
                  asset: asset,
                  onTap: () {
                    // TODO: Navigate to asset detail screen
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AssetItem extends StatelessWidget {
  final AssetItemDisplayModel asset;
  final VoidCallback? onTap;

  const _AssetItem({
    required this.asset,
    this.onTap,
  });

  IconData _getAssetIcon() {
    return Icons.settings;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Measurement.generalSize8.verticalPadding,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: Measurement.generalSize16.allPadding,
          decoration: BoxDecoration(
            color: AppColor.blueCard,
            borderRadius: Measurement.generalSize12.allRadius,
          ),
          child: Row(
            children: [
              // Asset Icon
              Container(
                width: Measurement.generalSize48,
                height: Measurement.generalSize48,
                decoration: BoxDecoration(
                  color: AppColor.blueStatusInner,
                  borderRadius: Measurement.generalSize8.allRadius,
                ),
                child: Icon(
                  _getAssetIcon(),
                  color: AppColor.white,
                  size: Measurement.generalSize24,
                ),
              ),
              Measurement.generalSize16.width,

              // Asset Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(asset.name).mediumBold(AppColor.white),
                    Measurement.generalSize4.height,
                    Text('${AppString.manufacturer}: ${asset.manufacturer},\n${AppString.assetID}: ${asset.model}')
                        .smallNormal(AppColor.grey),
                  ],
                ),
              ),

              // Navigation Arrow
              const Icon(
                Icons.chevron_right,
                color: AppColor.grey,
                size: Measurement.generalSize20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
