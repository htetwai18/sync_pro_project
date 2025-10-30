import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';

class TaskListItem extends StatelessWidget {
  final TaskItemDisplayModel item;
  final VoidCallback? onTap;

  const TaskListItem({super.key, required this.item, this.onTap});

  String _statusLabel(String status) => status.isEmpty
      ? ''
      : status[0].toUpperCase() + status.substring(1).replaceAll('_', ' ');
  Color _statusOuter(String s) {
    switch (s) {
      case 'pending':
        return AppColor.greyStatusOuter;
      case 'scheduled':
      case 'in_progress':
        return AppColor.orangeStatusOuter;
      case 'completed':
        return AppColor.greenStatusOuter;
      case 'overdue':
      case 'cancelled':
      case 'on_hold':
        return AppColor.redStatusOuter;
      default:
        return AppColor.blueField;
    }
  }

  Color _statusInner(String s) {
    switch (s) {
      case 'pending':
        return AppColor.greyStatusInner;
      case 'scheduled':
      case 'in_progress':
        return AppColor.orangeStatusInner;
      case 'completed':
        return AppColor.greenStatusInner;
      case 'overdue':
      case 'cancelled':
      case 'on_hold':
        return AppColor.redStatusInner;
      default:
        return AppColor.blueField;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: Measurement.generalSize12.allRadius,
      child: Container(
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
                    color: _statusOuter(item.status),
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                  child: Text(_statusLabel(item.status))
                      .smallBold(_statusInner(item.status)),
                ),
              ],
            ),
            Measurement.generalSize8.height,
            Text('${AppString.customer}: ${item.customer.name}')
                .smallNormal(AppColor.grey),
            Measurement.generalSize4.height,
            Text('${AppString.assigned}: ${item.assignedTo?.name ?? '-'}')
                .smallNormal(AppColor.grey),
          ],
        ),
      ),
    );
  }
}
