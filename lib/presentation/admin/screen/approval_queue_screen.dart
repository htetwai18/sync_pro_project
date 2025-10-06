import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_bar.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/extension.dart';
import 'package:sync_pro/config/measurement.dart';
import 'package:sync_pro/presentation/admin/display_models/approval_item_display_model.dart';
import 'package:sync_pro/presentation/admin/widgets/approval_list_item.dart';

/// The main screen widget
class ApprovalQueueScreen extends StatelessWidget {
  const ApprovalQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: getAppBar(
        title: AppString.approvalQueue,
        icon: Icons.menu,
        onTap: () {

        },
      ),
      body: ListView.builder(
        padding: Measurement.generalSize16.horizontalIsToVertical,
        itemCount: approvalItems.length,
        itemBuilder: (context, index) {
          final item = approvalItems[index];
          return ApprovalListItem(item: item);
        },
      ),
    );
  }
}
