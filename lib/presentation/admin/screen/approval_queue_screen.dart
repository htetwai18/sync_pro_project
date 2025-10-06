import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.background,
        elevation: Measurement.generalSize0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.white),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text(AppString.approvalQueue).largeBold(AppColor.white),
        centerTitle: true,
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
