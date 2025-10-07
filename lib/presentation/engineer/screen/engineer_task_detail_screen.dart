import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/config/enum.dart';

class EngineerTaskDetailScreen extends StatelessWidget {
  final String title;
  final TaskStatus status;
  final String description;
  final String locationName;
  final String address;

  const EngineerTaskDetailScreen({
    super.key,
    required this.title,
    required this.status,
    required this.description,
    required this.locationName,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: 'Task Details', context: context),
      body: SingleChildScrollView(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and status
            Text(title).xLargeBold(AppColor.white),
            Measurement.generalSize8.height,
            Row(
              children: [
                const Text(AppString.statusUpper).smallNormal(AppColor.grey),
                Measurement.generalSize8.width,
                Container(
                  padding: Measurement.generalSize8.horizontalIsToVertical,
                  decoration: BoxDecoration(
                    color: getTaskStatusInnerColor(status).withOpacity(0.15),
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Text(
                    _statusLabel(status),
                  ).smallBold(getTaskStatusInnerColor(status)),
                ),
              ],
            ),

            Measurement.generalSize16.height,

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
                    onPressed: () {},
                    child: const Text('Add Parts').mediumBold(AppColor.white),
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
                    onPressed: () {},
                    child: const Text('Report').mediumBold(AppColor.white),
                  ),
                ),
              ],
            ),

            Measurement.generalSize24.height,

            // Location & address
            const Text('Location & Address').mediumBold(AppColor.white),
            Measurement.generalSize12.height,
            Container(
              width: double.infinity,
              padding: Measurement.generalSize16.horizontalIsToVertical,
              decoration: BoxDecoration(
                color: AppColor.blueField,
                borderRadius: Measurement.generalSize12.allRadius,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(locationName).mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Text(address).smallNormal(AppColor.grey),
                ],
              ),
            ),

            Measurement.generalSize24.height,

            // Description
            const Text('Task Description').mediumBold(AppColor.white),
            Measurement.generalSize12.height,
            Text(description).mediumNormal(AppColor.grey),
          ],
        ),
      ),
    );
  }

  String _statusLabel(TaskStatus s) {
    switch (s) {
      case TaskStatus.notStarted:
        return AppString.notStarted;
      case TaskStatus.inProgress:
        return AppString.inProgress;
      case TaskStatus.completed:
        return AppString.completed;
      case TaskStatus.overdue:
        return AppString.overdue;
    }
  }
}
