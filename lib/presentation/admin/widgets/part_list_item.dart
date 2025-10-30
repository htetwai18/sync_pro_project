import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';

class PartListItem extends StatelessWidget {
  final PartModel item;
  final VoidCallback? onTap;

  const PartListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Measurement.generalSize16,
          vertical: Measurement.generalSize16,
        ),
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name).mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Text(item.number).smallNormal(AppColor.grey),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(AppString.onHand).smallNormal(AppColor.grey),
                Measurement.generalSize8.height,
                Text(item.onHand.toString()).largeBold(AppColor.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}
