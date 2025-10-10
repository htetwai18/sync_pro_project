import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/approval_item_display_model.dart';
import 'package:sync_pro/presentation/admin/widgets/read_only_field.dart';

class ApprovalDetailScreen extends StatelessWidget {
  final ApprovalItemDisplayModel item;

  const ApprovalDetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        context: context,
        title: AppString.approvalDetails,
      ),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.customerSubmission).mediumBold(AppColor.grey),
            Measurement.generalSize16.height,
            ReadOnlyField(
              label: AppString.buildingName,
              value: item.buildingName,
            ),
            Measurement.generalSize16.height,
            if (item.buildingRoomNumber != null)
              ReadOnlyField(
                label: AppString.roomNumber,
                value: item.buildingRoomNumber!,
              ),
            Measurement.generalSize16.height,
            ReadOnlyField(
              label: AppString.assetType,
              value: item.assetType,
            ),
            Measurement.generalSize16.height,
            ReadOnlyField(
              label: AppString.assetDescription,
              value: item.assetDescription,
              maxLines: 3,
            ),
            Measurement.generalSize16.height,
            ReadOnlyField(
              label: AppString.status,
              value: item.statusText,
            ),
            Measurement.generalSize16.height,
            ReadOnlyField(
              label: AppString.dateAdded,
              value: item.dateAdded,
            ),
            Measurement.generalSize16.height,
            ReadOnlyField(
              label: AppString.lastUpdated,
              value: item.lastUpdated,
            ),
            Measurement.generalSize24.height,
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.greyPercentCircle),
                      foregroundColor: AppColor.white,
                      padding: Measurement.generalSize16.horizontalIsToVertical,
                      shape: RoundedRectangleBorder(
                        borderRadius: Measurement.generalSize12.allRadius,
                      ),
                      backgroundColor: AppColor.blueField,
                    ),
                    onPressed: () {},
                    child:
                        const Text(AppString.reject).mediumBold(AppColor.white),
                  ),
                ),
                Measurement.generalSize16.width,
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blueStatusInner,
                      foregroundColor: AppColor.white,
                      padding: Measurement.generalSize16.horizontalIsToVertical,
                      shape: RoundedRectangleBorder(
                        borderRadius: Measurement.generalSize12.allRadius,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(AppString.approve)
                        .mediumBold(AppColor.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
