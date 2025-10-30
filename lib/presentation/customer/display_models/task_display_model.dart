import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/report_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/user_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';

class TaskOrRequestedServiceModel {
  /// General
  final String id;
  final String title;
  final String description;
  final String status;
  final String type;
  final String priority;
  final DateTime requestDate;
  final DateTime? completedDate;

  /// Customer Request Details
  final DateTime preferredDate;
  final String preferredTime;
  final String notes;

  /// Scheduling and Execution Details
  final String specialInstructions;
  final DateTime? assignedDate;
  final DateTime? scheduledDate;

  // --- Populated ERD Links (Aggregates) ---
  final CustomerModel customer;
  final BuildingModel building;
  final AssetModel asset;
  final UserModel createdBy;
  final UserModel? assignedTo;

  // --- Populated ERD Links (Children) ---
  final ReportModel? report;
  final List<PartModel>? parts;

  const TaskOrRequestedServiceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.type,
    required this.priority,
    required this.requestDate,
    this.completedDate,
    required this.preferredDate,
    required this.preferredTime,
    required this.notes,
    required this.specialInstructions,
    this.assignedDate,
    this.scheduledDate,
    required this.customer,
    required this.building,
    required this.asset,
    required this.createdBy,
    this.assignedTo,
    this.report,
    this.parts,
  });
}


