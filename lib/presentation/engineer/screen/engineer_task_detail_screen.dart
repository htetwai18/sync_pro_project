import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/routing.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_add_part_to_task_screen.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_service_report_screen.dart';

class EngineerTaskDetailScreen extends StatelessWidget {
  final String title, asset, assetName;
  final String status;
  final String description;
  final String locationName;
  final String address;
  final String? priority;
  final DateTime? scheduledAt;
  final DateTime? assignedAt;

  const EngineerTaskDetailScreen({
    super.key,
    required this.title,
    required this.asset,
    required this.assetName,
    required this.status,
    required this.description,
    required this.locationName,
    required this.address,
    this.priority,
    this.scheduledAt,
    this.assignedAt,
  });

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
            // Title and status
            Text(title).xLargeBold(AppColor.white),
            Measurement.generalSize24.height,
            Row(
              children: [
                const Text(AppString.statusUpper).smallNormal(AppColor.grey),
                Measurement.generalSize8.width,
                Container(
                  padding: Measurement.generalSize8.horizontalIsToVertical,
                  decoration: BoxDecoration(
                    color: _statusColor(status).withOpacity(0.15),
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Text(
                    _statusLabel(status),
                  ).smallBold(_statusColor(status)),
                ),
              ],
            ),

            Measurement.generalSize24.height,

            // Action buttons row
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
                    onPressed: () {
                      Routing.transition(context, const EngineerAddPartToTaskScreen());
                    },
                    child: const Text(AppString.addParts)
                        .mediumBold(AppColor.white),
                  ),
                ),
                Measurement.generalSize16.width,
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColor.greyPercentCircle),
                      foregroundColor: AppColor.white,
                      backgroundColor: AppColor.blueField,
                      padding: Measurement.generalSize16.horizontalIsToVertical,
                      shape: RoundedRectangleBorder(
                        borderRadius: Measurement.generalSize12.allRadius,
                      ),
                    ),
                    onPressed: () {
                      Routing.transition(context, const EngineerServiceReportScreen());
                    },
                    child: const Text(AppString.reportAction)
                        .mediumBold(AppColor.white),
                  ),
                ),
              ],
            ),

            Measurement.generalSize24.height,

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locationName).smallNormal(AppColor.grey),
                Measurement.generalSize8.height,
                Text(address).mediumBold(AppColor.white),
              ],
            ),
            Measurement.generalSize24.height,

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${AppString.assetID}: $asset').smallNormal(AppColor.grey),
                Measurement.generalSize4.height,
                Text(assetName).mediumBold(AppColor.white),
              ],
            ),

            Measurement.generalSize24.height,

            // Meta (priority/scheduled/assigned)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (priority != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Priority').smallNormal(AppColor.grey),
                      Measurement.generalSize4.height,
                      Text(priority!).mediumBold(AppColor.white),
                    ],
                  ),
                ],
                Measurement.generalSize24.height,
                if (scheduledAt != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppString.scheduledAtLabel)
                          .smallNormal(AppColor.grey),
                      Measurement.generalSize4.height,
                      Text(_fmtDateTime(scheduledAt!))
                          .mediumBold(AppColor.white),
                    ],
                  ),
                ],
                Measurement.generalSize24.height,
                if (assignedAt != null) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(AppString.assignedAtLabel)
                          .smallNormal(AppColor.grey),
                      Measurement.generalSize4.height,
                      Text(_fmtDateTime(assignedAt!))
                          .mediumBold(AppColor.white),
                    ],
                  ),
                ],
              ],
            ),

            Measurement.generalSize24.height,

            // Description
            const Text(AppString.taskDescription).smallNormal(AppColor.grey),
            Measurement.generalSize12.height,
            Text(description).mediumBold(AppColor.white),
          ],
        ),
      ),
    );
  }

  String _statusLabel(String s) {
    if (s.isEmpty) return '';
    return s[0].toUpperCase() + s.substring(1).replaceAll('_', ' ');
  }

  Color _statusColor(String s) {
    switch (s) {
      case 'pending':
        return AppColor.greyStatusInner;
      case 'scheduled':
      case 'in_progress':
        return AppColor.orangeStatusInner;
      case 'completed':
        return AppColor.greenStatusInner;
      case 'cancelled':
      case 'on_hold':
      case 'overdue':
        return AppColor.redStatusInner;
      default:
        return AppColor.blueField;
    }
  }

  String _fmtDateTime(DateTime dt) {
    final d =
        '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    final t =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    return '$d $t';
  }
}
