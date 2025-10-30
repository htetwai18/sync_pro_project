// import 'user_model.dart';
// import 'task_or_requested_service_model.dart';

import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/task_display_model.dart';

class ReportModel {
  final String id;
  final String title;
  final String submittedDate;
  final String? approvedDate;
  final String content;
  final String? attachmentUrl;
  final String status;
  final TaskOrRequestedServiceModel task;
  final UserModel submittedBy;
  final UserModel? reviewedBy;

  const ReportModel({
    required this.id,
    required this.title,
    required this.submittedDate,
    this.approvedDate,
    required this.content,
    this.attachmentUrl,
    required this.status,
    required this.task,
    required this.submittedBy,
    this.reviewedBy,
  });
}

