import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';
import 'package:sync_pro/config/app_string.dart';

enum LoadingState { loading, success, error }

enum TaskStatus { notStarted, inProgress, completed, overdue }

enum InvoiceStatus { paid, due, overdue, sent, voided, draft }

enum UserRole { admin, engineer, manager }

enum TaskPriority { low, medium, high, urgent }

enum TaskType {
  maintenance,
  repair,
  installation,
  inspection,
  emergency,
  other
}

// Helper functions to get display strings
String getTaskStatusText(TaskStatus status) {
  switch (status) {
    case TaskStatus.notStarted:
      return AppString.pending;
    case TaskStatus.inProgress:
      return AppString.inProgress;
    case TaskStatus.completed:
      return AppString.completed;
    case TaskStatus.overdue:
      return AppString.overdue;
  }
}

String getTaskPriorityText(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.low:
      return AppString.low;
    case TaskPriority.medium:
      return AppString.medium;
    case TaskPriority.high:
      return AppString.high;
    case TaskPriority.urgent:
      return AppString.urgent;
  }
}

String getTaskTypeText(TaskType type) {
  switch (type) {
    case TaskType.maintenance:
      return AppString.maintenance;
    case TaskType.repair:
      return AppString.repair;
    case TaskType.installation:
      return AppString.installation;
    case TaskType.inspection:
      return AppString.inspection;
    case TaskType.emergency:
      return AppString.emergency;
    case TaskType.other:
      return AppString.other;
  }
}

Color getInvoiceStatusOuterColor(InvoiceStatus status) {
  switch (status) {
    case InvoiceStatus.paid:
      return AppColor.greenStatusOuter;
    case InvoiceStatus.due:
      return AppColor.orangeStatusOuter;
    case InvoiceStatus.overdue:
      return AppColor.redStatusOuter;
    case InvoiceStatus.voided:
      return AppColor.redStatusOuter;
    case InvoiceStatus.sent:
      return AppColor.blueStatusOuter;
    case InvoiceStatus.draft:
      return AppColor.greyStatusOuter;
    default:
      return AppColor.greyStatusOuter;
  }
}

Color getInvoiceStatusInnerColor(InvoiceStatus status) {
  switch (status) {
    case InvoiceStatus.paid:
      return AppColor.greenStatusInner;
    case InvoiceStatus.due:
      return AppColor.orangeStatusInner;
    case InvoiceStatus.overdue:
      return AppColor.redStatusInner;
    case InvoiceStatus.voided:
      return AppColor.redStatusInner;
    case InvoiceStatus.sent:
      return AppColor.blueStatusInner;
    case InvoiceStatus.draft:
      return AppColor.greyStatusInner;
    default:
      return AppColor.greyStatusInner;
  }
}

Color getTaskStatusOuterColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.notStarted:
      return AppColor.greyStatusOuter;
    case TaskStatus.inProgress:
      return AppColor.orangeStatusOuter;
    case TaskStatus.completed:
      return AppColor.greenStatusOuter;
    case TaskStatus.overdue:
      return AppColor.redStatusOuter;
    default:
      return AppColor.greyStatusOuter;
  }
}

Color getTaskStatusInnerColor(TaskStatus status) {
  switch (status) {
    case TaskStatus.notStarted:
      return AppColor.greyStatusInner;
    case TaskStatus.inProgress:
      return AppColor.orangeStatusInner;
    case TaskStatus.completed:
      return AppColor.greenStatusInner;
    case TaskStatus.overdue:
      return AppColor.redStatusInner;
    default:
      return AppColor.greyStatusInner;
  }
}
