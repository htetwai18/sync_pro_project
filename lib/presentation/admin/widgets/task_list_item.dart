import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/enum.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';

class TaskListItem extends StatelessWidget {
  final TaskItemDisplayModel item;
  final VoidCallback? onTap;

  const TaskListItem({super.key, required this.item, this.onTap});

  String _statusLabel(TaskStatus status) {
    switch (status) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Measurement.generalSize16,
        vertical: Measurement.generalSize16,
      ),
      decoration: BoxDecoration(
        color: AppColor.blueField,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(item.title).mediumBold(AppColor.white)),
              Container(
                padding: Measurement.generalSize8.horizontalIsToVertical,
                decoration: BoxDecoration(
                  color: getTaskStatusOuterColor(item.status),
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Text(_statusLabel(item.status))
                    .smallBold(getTaskStatusInnerColor(item.status)),
              ),
            ],
          ),
          Measurement.generalSize8.height,
          Text('${AppString.customer}: ${item.customer}')
              .smallNormal(AppColor.grey),
          Measurement.generalSize4.height,
          Text('${AppString.assigned}: ${item.assignedTo}')
              .smallNormal(AppColor.grey),
        ],
      ),
    );
  }
}
