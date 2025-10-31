import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/engineer/screen/engineer_add_part_to_task_screen.dart';
// removed unused part model import
import 'package:sync_pro/presentation/engineer/screen/engineer_service_report_screen.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';

class EngineerTaskDetailScreen extends StatefulWidget {
  final String taskId;
  const EngineerTaskDetailScreen({super.key, required this.taskId});

  @override
  State<EngineerTaskDetailScreen> createState() =>
      _EngineerTaskDetailScreenState();
}

class _EngineerTaskDetailScreenState extends State<EngineerTaskDetailScreen> {
  TaskOrRequestedServiceModel? _task;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final t = await MockApiService.instance.getTask(widget.taskId);
    setState(() => _task = t);
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) {
      return const Scaffold(
        backgroundColor: AppColor.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    final task = _task!;
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context, _changed);
          return false;
        },
        child: Scaffold(
          backgroundColor: AppColor.background,
          appBar:
              getAppBar(title: AppString.taskDetailsTitle, context: context),
          body: SingleChildScrollView(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and status
                Text(task.title).xLargeBold(AppColor.white),
                Measurement.generalSize24.height,
                Row(
                  children: [
                    const Text(AppString.statusUpper)
                        .smallNormal(AppColor.grey),
                    Measurement.generalSize8.width,
                    Container(
                      padding: Measurement.generalSize8.horizontalIsToVertical,
                      decoration: BoxDecoration(
                        color: _statusColor(task.status).withOpacity(0.15),
                        borderRadius: Measurement.generalSize12.allRadius,
                      ),
                      child: Text(
                        _statusLabel(task.status),
                      ).smallBold(_statusColor(task.status)),
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
                          backgroundColor: task.report != null
                              ? AppColor.greyPercentCircle
                              : AppColor.blueStatusInner,
                          foregroundColor: AppColor.white,
                          padding:
                              Measurement.generalSize16.horizontalIsToVertical,
                          shape: RoundedRectangleBorder(
                            borderRadius: Measurement.generalSize12.allRadius,
                          ),
                        ),
                        onPressed: task.report != null
                            ? null
                            : () async {
                                final selected = await Navigator.push<
                                    List<Map<String, dynamic>>>(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const EngineerAddPartToTaskScreen(),
                                  ),
                                );
                                if (selected != null && selected.isNotEmpty) {
                                  await MockApiService.instance
                                      .addTaskParts(task.id, selected);
                                  await _load();
                                  _changed = true;
                                }
                              },
                        child:
                            Text(AppString.addParts).mediumBold(AppColor.white),
                      ),
                    ),
                    Measurement.generalSize16.width,
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                              color: task.report != null
                                  ? AppColor.greyPercentCircle.withOpacity(0.5)
                                  : AppColor.greyPercentCircle),
                          foregroundColor: task.report != null
                              ? AppColor.grey
                              : AppColor.white,
                          backgroundColor: task.report != null
                              ? AppColor.greyPercentCircle.withOpacity(0.3)
                              : AppColor.blueField,
                          padding:
                              Measurement.generalSize16.horizontalIsToVertical,
                          shape: RoundedRectangleBorder(
                            borderRadius: Measurement.generalSize12.allRadius,
                          ),
                        ),
                        onPressed: task.report != null
                            ? null
                            : () async {
                                final ok = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => EngineerServiceReportScreen(
                                        taskId: task.id),
                                  ),
                                );
                                if (ok == true) {
                                  await _load();
                                  _changed = true;
                                  if (!mounted) return;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Report submitted successfully'),
                                    ),
                                  );
                                }
                              },
                        child: Text(AppString.reportAction)
                            .mediumBold(AppColor.white),
                      ),
                    ),
                  ],
                ),

                Measurement.generalSize24.height,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.customer.name).smallNormal(AppColor.grey),
                    Measurement.generalSize8.height,
                    Text(task.building.address).mediumBold(AppColor.white),
                  ],
                ),
                Measurement.generalSize24.height,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${AppString.assetID}: ${task.asset.id}')
                        .smallNormal(AppColor.grey),
                    Measurement.generalSize4.height,
                    Text(task.asset.name).mediumBold(AppColor.white),
                  ],
                ),

                Measurement.generalSize24.height,

                // Meta (priority/scheduled/assigned)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (task.priority.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Priority').smallNormal(AppColor.grey),
                          Measurement.generalSize4.height,
                          Text(task.priority).mediumBold(AppColor.white),
                        ],
                      ),
                    ],
                    Measurement.generalSize24.height,
                    if (task.scheduledDate != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(AppString.scheduledAtLabel)
                              .smallNormal(AppColor.grey),
                          Measurement.generalSize4.height,
                          Text(_fmtDateTime(task.scheduledDate!))
                              .mediumBold(AppColor.white),
                        ],
                      ),
                    ],
                    Measurement.generalSize24.height,
                    if (task.assignedDate != null) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(AppString.assignedAtLabel)
                              .smallNormal(AppColor.grey),
                          Measurement.generalSize4.height,
                          Text(_fmtDateTime(task.assignedDate!))
                              .mediumBold(AppColor.white),
                        ],
                      ),
                    ],
                  ],
                ),

                Measurement.generalSize24.height,

                // Description
                const Text(AppString.taskDescription)
                    .smallNormal(AppColor.grey),
                Measurement.generalSize12.height,
                Text(task.description).mediumBold(AppColor.white),

                Measurement.generalSize24.height,

                // Parts section
                const Text('Parts').smallNormal(AppColor.grey),
                Measurement.generalSize8.height,
                if ((task.parts?.isEmpty ?? true))
                  Text('No parts added').smallNormal(AppColor.grey)
                else
                  Column(
                    children: task.parts!.map((p) {
                      final qty = task.partsQuantity?[p.id] ?? 0;
                      return Container(
                        margin: Measurement.generalSize8.verticalPadding,
                        padding:
                            Measurement.generalSize12.horizontalIsToVertical,
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
                                  Text(p.name).mediumBold(AppColor.white),
                                  Measurement.generalSize4.height,
                                  Row(
                                    children: [
                                      Text(p.number).smallNormal(AppColor.grey),
                                      if (qty > 0) ...[
                                        Measurement.generalSize8.width,
                                        Text('Qty: $qty')
                                            .smallNormal(AppColor.white),
                                      ],
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ));
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
