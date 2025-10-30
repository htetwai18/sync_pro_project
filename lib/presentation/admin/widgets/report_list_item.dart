import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/report_item_display_model.dart';

class ReportListItem extends StatelessWidget {
  final ReportModel item;
  final VoidCallback? onTap;

  const ReportListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Measurement.generalSize16,
        vertical: Measurement.generalSize12,
      ),
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Row(
        children: [
          Container(
            width: Measurement.generalSize48,
            height: Measurement.generalSize48,
            decoration: BoxDecoration(
              color: AppColor.blueStatusOuter,
              borderRadius: Measurement.generalSize10.allRadius,
            ),
            child:
                const Icon(Icons.description, color: AppColor.blueStatusInner),
          ),
          Measurement.generalSize12.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title).mediumBold(AppColor.white),
                Measurement.generalSize8.height,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${AppString.customer}: ${item.customer}',
                        overflow: TextOverflow.ellipsis,
                      ).smallNormal(AppColor.grey),
                    ),
                  ],
                ),
                Measurement.generalSize4.height,
                Text(
                  '${item.author} | ${item.date}',
                  overflow: TextOverflow.ellipsis,
                ).smallNormal(AppColor.grey),
              ],
            ),
          ),
          IconButton(
            onPressed: onTap,
            icon: const Icon(Icons.chevron_right, color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}
