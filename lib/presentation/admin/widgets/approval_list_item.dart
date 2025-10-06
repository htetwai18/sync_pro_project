// A reusable widget for displaying a single item in the list
import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/admin/display_models/approval_item_display_model.dart';
import 'package:sync_pro/presentation/admin/screen/approval_detail_screen.dart';

class ApprovalListItem extends StatelessWidget {
  final ApprovalItemDisplayModel item;

  const ApprovalListItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.blueField,
      shape: RoundedRectangleBorder(
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      margin: Measurement.generalSize8.verticalPadding,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Measurement.generalSize16,
          vertical: Measurement.generalSize12,
        ),
        leading: Container(
          padding: Measurement.generalSize12.allPadding,
          decoration: BoxDecoration(
            color: AppColor.blueStatusOuter,
            borderRadius: Measurement.generalSize10.allRadius,
          ),
          child: Icon(
            item.icon,
            color: AppColor.blueStatusInner,
            size: Measurement.generalSize18,
          ),
        ),
        title: Text(
          item.title,
        ).mediumNormal(AppColor.white),
        subtitle: Text(
          '${AppString.submittedBy}: ${item.submittedBy}',
        ).smallNormal(AppColor.grey),
        trailing: const Icon(
          Icons.chevron_right,
          color: AppColor.grey,
        ),
        onTap: () {
          Routing.transition(context, ApprovalDetailScreen(item: item));
        },
      ),
    );
  }
}
