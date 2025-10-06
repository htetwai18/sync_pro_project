import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskItemDisplayModel item;

  const TaskDetailScreen({super.key, required this.item});

  String _format(DateTime? dt) {
    if (dt == null) return '';
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    final yyyy = dt.year.toString();
    final hh = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    return '$yyyy-$mm-$dd $hh:$min';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.taskDetailsTitle, context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(AppString.taskDescription).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            Container(
              width: double.infinity,
              padding: Measurement.generalSize16.horizontalIsToVertical,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: Text(item.description).mediumNormal(AppColor.white),
            ),
            Measurement.generalSize24.height,
            const Text(AppString.assetUpper).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            Container(
              padding: Measurement.generalSize16.horizontalIsToVertical,
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
                    child: const Icon(
                      Icons.insert_drive_file,
                      color: AppColor.blueStatusInner,
                    ),
                  ),
                  Measurement.generalSize12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppString.assetID}: ${item.assetId}')
                            .mediumBold(AppColor.white),
                        Measurement.generalSize4.height,
                        Text(item.assetName).smallNormal(AppColor.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Measurement.generalSize24.height,
            const Text(AppString.timeline).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            _TimelineTile(
              icon: Icons.radio_button_unchecked,
              title: AppString.taskCreated,
              subtitle: _format(item.createdAt),
            ),
            _TimelineDivider(),
            _TimelineTile(
              icon: Icons.radio_button_unchecked,
              title: AppString.assignedToEngineer,
              subtitle: _format(item.assignedAt),
            ),
            _TimelineDivider(),
            _TimelineTile(
              icon: Icons.check_circle,
              iconColor: AppColor.greenStatusInner,
              title: AppString.taskCompleted,
              subtitle: _format(item.completedAt),
            ),
            Measurement.generalSize24.height,
            const Text(AppString.serviceReport).mediumBold(AppColor.grey),
            Measurement.generalSize8.height,
            Container(
              padding: Measurement.generalSize16.horizontalIsToVertical,
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
                    child: const Icon(Icons.description,
                        color: AppColor.blueStatusInner),
                  ),
                  Measurement.generalSize12.width,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(AppString.viewReport)
                            .mediumBold(AppColor.white),
                        Measurement.generalSize4.height,
                        Text('${AppString.submittedOn} ${_format(item.completedAt).split(' ').first}')
                            .smallNormal(AppColor.grey),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Measurement.generalSize24.height,
            Row(
              children: [
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
                Measurement.generalSize16.width,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;

  const _TimelineTile({
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(icon, color: iconColor ?? AppColor.blueStatusInner),
          ],
        ),
        Measurement.generalSize12.width,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title).mediumBold(AppColor.white),
              Measurement.generalSize4.height,
              Text(subtitle).smallNormal(AppColor.grey),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Measurement.generalSize12),
      child: Container(
        margin: const EdgeInsets.only(left: 24),
        height: Measurement.generalSize24,
        width: Measurement.generalSize2,
        color: AppColor.greyPercentCircle.withOpacity(0.2),
      ),
    );
  }
}
