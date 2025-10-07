import 'package:flutter/material.dart';
import 'package:sync_pro/config/app_color.dart';

enum LoadingState { loading, success, error }

enum TaskStatus { notStarted, inProgress, completed, overdue }

enum InvoiceStatus { paid, due, overdue, sent, voided, draft }

enum UserRole { admin, engineer, manager }

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
