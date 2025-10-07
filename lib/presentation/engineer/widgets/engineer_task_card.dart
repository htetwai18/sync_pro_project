import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/engineer/display_models/engineer_task_display_model.dart';

class EngineerTaskCard extends StatelessWidget {
  final EngineerTaskDisplayModel task;
  final VoidCallback? onTap;
  const EngineerTaskCard({super.key, required this.task, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        padding: Measurement.generalSize16.horizontalIsToVertical,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Measurement.generalSize40,
              height: Measurement.generalSize40,
              decoration: BoxDecoration(
                color: AppColor.blueStatusOuter,
                borderRadius: Measurement.generalSize10.allRadius,
              ),
              child: const Icon(Icons.work_outline, color: AppColor.white),
            ),
            Measurement.generalSize18.width,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title).mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Text(task.customer).smallNormal(AppColor.grey),
                  Measurement.generalSize4.height,
                  Text(task.address).smallNormal(AppColor.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
