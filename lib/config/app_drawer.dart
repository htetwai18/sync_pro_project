import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/screen/approval_queue_screen.dart';
import 'package:sync_pro/presentation/admin/screen/reports_review_screen.dart';
import 'package:sync_pro/presentation/admin/screen/tasks_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.background,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: Measurement.generalSize8,
          ),
          children: [
            ListTile(
              leading: const Icon(Icons.checklist, color: AppColor.white),
              title: const Text(AppString.approvalQueue)
                  .mediumBold(AppColor.white),
              onTap: () => _navigate(context, const ApprovalQueueScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.article, color: AppColor.white),
              title: const Text(AppString.reportsToBeReviewed)
                  .mediumBold(AppColor.white),
              onTap: () => _navigate(context, const ReportsReviewScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.task_alt, color: AppColor.white),
              title: const Text(AppString.tasks).mediumBold(AppColor.white),
              onTap: () => _navigate(context, const TasksScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
