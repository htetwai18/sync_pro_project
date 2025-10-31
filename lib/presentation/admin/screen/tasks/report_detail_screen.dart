import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/report_item_display_model.dart';

class ReportDetailScreen extends StatefulWidget {
  final ReportModel item;

  const ReportDetailScreen({super.key, required this.item});

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  late ReportModel item;
  bool _changed = false;

  @override
  void initState() {
    super.initState();
    item = widget.item;
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
        appBar: getAppBar(
          context: context,
          title: AppString.reviewReport,
        ),
        body: SingleChildScrollView(
          padding: Measurement.generalSize16.horizontalIsToVertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Report Content section
              const Text(AppString.reportContent).mediumBold(AppColor.grey),
              Measurement.generalSize16.height,
              Text(item.content).mediumNormal(AppColor.white),

              Measurement.generalSize24.height,
              // Attachments
              const Text(AppString.attachments).mediumBold(AppColor.grey),
              Measurement.generalSize16.height,
              Padding(
                padding:
                    const EdgeInsets.only(bottom: Measurement.generalSize16),
                child: ClipRRect(
                  borderRadius: Measurement.generalSize12.allRadius,
                  child: Image.network(item.attachmentUrl ?? "",
                      fit: BoxFit.cover),
                ),
              ),
              Measurement.generalSize24.height,
              // Task Details
              const Text(AppString.taskDetails).mediumBold(AppColor.grey),
              Measurement.generalSize16.height,
              _DetailRow(label: AppString.taskId, value: item.task.id),
              _Divider(),
              _DetailRow(
                  label: AppString.engineer, value: item.submittedBy.name),
              _Divider(),
              _DetailRow(label: AppString.date, value: item.submittedDate),
              _Divider(),
              _DetailRow(label: AppString.status, value: item.status),

              Measurement.generalSize24.height,
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side:
                            const BorderSide(color: AppColor.greyPercentCircle),
                        foregroundColor: AppColor.white,
                        padding:
                            Measurement.generalSize16.horizontalIsToVertical,
                        shape: RoundedRectangleBorder(
                          borderRadius: Measurement.generalSize12.allRadius,
                        ),
                        backgroundColor: AppColor.blueField,
                      ),
                      onPressed: () {
                        setState(() {
                          item = ReportModel(
                            id: item.id,
                            title: item.title,
                            submittedDate: item.submittedDate,
                            approvedDate: item.approvedDate,
                            content: item.content,
                            attachmentUrl: item.attachmentUrl,
                            status: 'rejected',
                            task: item.task,
                            submittedBy: item.submittedBy,
                            reviewedBy: item.reviewedBy,
                          );
                          _changed = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Report rejected.')),
                        );
                      },
                      child: const Text(AppString.reject)
                          .mediumBold(AppColor.white),
                    ),
                  ),
                  Measurement.generalSize16.width,
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.blueStatusInner,
                        foregroundColor: AppColor.white,
                        padding:
                            Measurement.generalSize16.horizontalIsToVertical,
                        shape: RoundedRectangleBorder(
                          borderRadius: Measurement.generalSize12.allRadius,
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          item = ReportModel(
                            id: item.id,
                            title: item.title,
                            submittedDate: item.submittedDate,
                            approvedDate: item.approvedDate,
                            content: item.content,
                            attachmentUrl: item.attachmentUrl,
                            status: 'approved',
                            task: item.task,
                            submittedBy: item.submittedBy,
                            reviewedBy: item.reviewedBy,
                          );
                          _changed = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Report approved.')),
                        );
                      },
                      child: const Text(AppString.approve)
                          .mediumBold(AppColor.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Measurement.generalSize14,
      ),
      child: Row(
        children: [
          Expanded(child: Text(label).smallNormal(AppColor.grey)),
          Text(value).mediumBold(AppColor.white),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: AppColor.greyPercentCircle.withOpacity(0.2),
    );
  }
}
