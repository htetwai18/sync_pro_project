import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';

class CustomerAssetDetailScreen extends StatelessWidget {
  final AssetItemDisplayModel asset;

  const CustomerAssetDetailScreen({
    super.key,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.assetDetails,
        context: context,
        canBack: true,
      ),
      body: Column(
        children: [
          // Asset Information Section
          Expanded(
            child: SingleChildScrollView(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Measurement.generalSize24.height,

                  // Asset Information Header
                  const Text(AppString.assetInformation)
                      .largeBold(AppColor.white),
                  Measurement.generalSize16.height,

                  // Asset Information Card
                  Container(
                    padding: Measurement.generalSize20.allPadding,
                    decoration: BoxDecoration(
                      color: AppColor.blueCard,
                      borderRadius: Measurement.generalSize12.allRadius,
                    ),
                    child: Column(
                      children: [
                        Measurement.generalSize24.height,
                        _InfoRow(
                          label: AppString.assetID,
                          value: asset.id,
                        ),
                        Measurement.generalSize16.height,
                        const Divider(color: AppColor.grey, height: 0.3),
                        Measurement.generalSize24.height,
                        _InfoRow(
                          label: AppString.assetName,
                          value: asset.name,
                        ),
                        Measurement.generalSize16.height,
                        const Divider(color: AppColor.grey, height: 0.3),
                        Measurement.generalSize24.height,
                        _InfoRow(
                          label: AppString.manufacturer,
                          value: asset.manufacturer,
                        ),
                        Measurement.generalSize16.height,
                        const Divider(color: AppColor.grey, height: 0.3),
                        Measurement.generalSize24.height,
                        _InfoRow(
                          label: AppString.model,
                          value: asset.model,
                        ),
                        Measurement.generalSize16.height,
                        const Divider(color: AppColor.grey, height: 0.3),
                        Measurement.generalSize24.height,
                        _InfoRow(
                          label: AppString.installationDate,
                          value: asset.installationDate != null
                              ? '${asset.installationDate!.year}-${asset.installationDate!.month.toString().padLeft(2, '0')}-${asset.installationDate!.day.toString().padLeft(2, '0')}'
                              : 'N/A',
                        ),
                        Measurement.generalSize16.height,
                        const Divider(color: AppColor.grey, height: 0.3),
                      ],
                    ),
                  ),

                  Measurement.generalSize24.height,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label).mediumNormal(AppColor.grey),
        ),
        Expanded(
          flex: 3,
          child: Text(value).mediumBold(AppColor.white),
        ),
      ],
    );
  }
}
