import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/data/mock_api/mock_api_service.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';

class EngineerServiceReportScreen extends StatefulWidget {
  final String taskId;
  const EngineerServiceReportScreen({super.key, required this.taskId});

  @override
  State<EngineerServiceReportScreen> createState() =>
      _EngineerServiceReportScreenState();
}

class _EngineerServiceReportScreenState
    extends State<EngineerServiceReportScreen> {
  final TextEditingController _summaryController = TextEditingController();
  TaskOrRequestedServiceModel? _task;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  Future<void> _loadTask() async {
    final task = await MockApiService.instance.getTask(widget.taskId);
    setState(() => _task = task);
  }

  @override
  void dispose() {
    _summaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) {
      return Scaffold(
        backgroundColor: AppColor.background,
        appBar:
            getAppBar(title: AppString.serviceReportTitle, context: context),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(title: AppString.serviceReportTitle, context: context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: Measurement.generalSize16.horizontalIsToVertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(AppString.summaryOfWork)
                      .mediumBold(AppColor.white),
                  Measurement.generalSize8.height,
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.blueField,
                      borderRadius: Measurement.generalSize12.allRadius,
                    ),
                    padding: Measurement.generalSize16.horizontalIsToVertical,
                    child: TextField(
                      controller: _summaryController,
                      maxLines: 6,
                      minLines: 6,
                      style: Measurement.mediumFont
                          .textStyle(AppColor.white, Measurement.font400),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: AppString.summaryPlaceholder,
                        hintStyle: Measurement.mediumFont
                            .textStyle(AppColor.grey, Measurement.font400),
                      ),
                    ),
                  ),
                  Measurement.generalSize24.height,
                  const Text(AppString.attachmentsLabel)
                      .mediumBold(AppColor.white),
                  Measurement.generalSize12.height,
                  _ActionTile(
                    icon: Icons.image_outlined,
                    title: AppString.addPhotosAttachments,
                    trailing: Icons.chevron_right,
                    onTap: () {

                    },
                  ),
                  // Measurement.generalSize24.height,
                  // _ActionTile(
                  //   icon: Icons.draw_outlined,
                  //   title:
                  //       '${AppString.customerSignature} ${AppString.optionalLabel}',
                  //   trailing: Icons.chevron_right,
                  //   onTap: () {},
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: Measurement.generalSize16.horizontalIsToVertical,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueStatusInner,
                  foregroundColor: AppColor.white,
                  padding: Measurement.generalSize16.horizontalIsToVertical,
                  shape: RoundedRectangleBorder(
                    borderRadius: Measurement.generalSize12.allRadius,
                  ),
                ),
                onPressed: () async {
                  final content = _summaryController.text.trim();
                  if (content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please enter report content')),
                    );
                    return;
                  }
                  final submitterId = _task!.assignedTo?.id;
                  if (submitterId == null) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('No assigned engineer found')),
                    );
                    return;
                  }
                  await MockApiService.instance.createReport(
                    taskId: widget.taskId,
                    title: 'Service Report',
                    content: content,
                    submittedById: submitterId,
                  );
                  if (!mounted) return;
                  Navigator.pop(context, true);
                },
                child: const Text(AppString.submitReport)
                    .mediumBold(AppColor.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData trailing;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: Measurement.generalSize12.allRadius,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.blueField,
          borderRadius: Measurement.generalSize12.allRadius,
        ),
        padding: Measurement.generalSize16.allPadding,
        child: Row(
          children: [
            Container(
              width: Measurement.generalSize40,
              height: Measurement.generalSize40,
              decoration: BoxDecoration(
                color: AppColor.blueStatusOuter,
                borderRadius: Measurement.generalSize10.allRadius,
              ),
              child: Icon(icon, color: AppColor.white),
            ),
            Measurement.generalSize12.width,
            Expanded(child: Text(title).mediumBold(AppColor.white)),
            Icon(trailing, color: AppColor.grey),
          ],
        ),
      ),
    );
  }
}
