import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/task_item_display_model.dart';
import 'package:sync_pro/presentation/admin/screen/tasks/report_detail_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskItemDisplayModel item;

  const TaskDetailScreen({super.key, required this.item});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TaskItemDisplayModel item;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _changed);
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          backgroundColor: AppColor.background,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColor.white),
            onPressed: () => Navigator.pop(context, _changed),
          ),
          title: const Text(AppString.taskDetailsTitle),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: Measurement.generalSize16.horizontalIsToVertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Info
              Container(
                width: double.infinity,
                padding: Measurement.generalSize8.horizontalIsToVertical,
                decoration: BoxDecoration(
                  color: AppColor.blueField,
                  borderRadius: Measurement.generalSize12.allRadius,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title).largeBold(AppColor.white),
                    Measurement.generalSize8.height,
                    Row(
                      children: [
                        _Chip(label: 'Status', value: item.status),
                        Measurement.generalSize8.width,
                        _Chip(label: 'Priority', value: item.priority),
                        Measurement.generalSize8.width,
                        _Chip(label: 'Type', value: item.type),
                      ],
                    ),
                    Measurement.generalSize12.height,
                    const Divider(height: 1, color: AppColor.background),
                    Measurement.generalSize12.height,
                    _KV(k: 'Customer', v: item.customer.name),
                    _KV(k: 'Building', v: item.building.name),
                    if (item.building.roomNumber != null)
                      _KV(k: 'Room', v: item.building.roomNumber!),
                    _KV(k: 'Asset', v: '${item.asset.name} (${item.asset.id})'),
                    _KV(
                        k: 'Assigned Engineer',
                        v: item.assignedTo?.name ?? '-'),
                    _KV(k: 'Scheduled', v: _format(item.scheduledDate)),
                  ],
                ),
              ),
              Measurement.generalSize24.height,
              const Text(AppString.taskDescription).mediumBold(AppColor.white),
              Measurement.generalSize12.height,
              Text(item.description).mediumNormal(AppColor.grey),
              Measurement.generalSize24.height,
              const Text(AppString.assetUpper).mediumBold(AppColor.white),
              Measurement.generalSize12.height,
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
                          Text('${AppString.assetID}: ${item.asset.id}')
                              .mediumBold(AppColor.white),
                          Measurement.generalSize4.height,
                          Text(item.title).smallNormal(AppColor.grey),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Measurement.generalSize24.height,
              const Text(AppString.timeline).mediumBold(AppColor.grey),
              Measurement.generalSize12.height,
              _TimelineTile(
                icon: Icons.radio_button_unchecked,
                title: AppString.taskCreated,
                subtitle: _format(item.requestDate),
              ),
              _TimelineDivider(),
              _TimelineTile(
                icon: Icons.radio_button_unchecked,
                title: AppString.assignedToEngineer,
                subtitle: _format(item.assignedDate),
              ),
              _TimelineDivider(),
              _TimelineTile(
                icon: Icons.check_circle,
                iconColor: AppColor.greenStatusInner,
                title: AppString.taskCompleted,
                subtitle: _format(item.completedDate),
              ),
              Measurement.generalSize24.height,
              if (item.report != null)
                const Text(AppString.serviceReport).mediumBold(AppColor.white),
              Measurement.generalSize12.height,
              if (item.report != null)
                InkWell(
                  onTap: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ReportDetailScreen(item: item.report!),
                      ),
                    );
                    if (updated == true) setState(() => _changed = true);
                  },
                  child: Container(
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
                              Text('${AppString.submittedOn} ${_format(item.completedDate).split(' ').first}')
                                  .smallNormal(AppColor.grey),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
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

class _KV extends StatelessWidget {
  final String k;
  final String v;
  const _KV({required this.k, required this.v});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 140, child: Text(k).smallNormal(AppColor.grey)),
          Expanded(child: Text(v).smallNormal(AppColor.white)),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final String value;
  const _Chip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Measurement.generalSize4.horizontalIsToVertical,
      decoration: BoxDecoration(
        color: AppColor.blueStatusOuter,
        borderRadius: Measurement.generalSize12.allRadius,
      ),
      child: Row(
        children: [
          Text(label).smallBold(AppColor.grey),
          const SizedBox(width: 6),
          Text(value).smallBold(AppColor.white),
        ],
      ),
    );
  }
}
