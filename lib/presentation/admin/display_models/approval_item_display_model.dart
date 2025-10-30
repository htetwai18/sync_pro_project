// Data model for each item in the approval queue
import 'package:flutter/material.dart';

class ApprovalItemDisplayModel {
  final String title;
  final String submittedBy;
  final IconData icon;
  // detail fields
  final String buildingName;
  final String? buildingRoomNumber;
  final String assetType;
  final String assetDescription;
  final String statusText;
  final String dateAdded;
  final String lastUpdated;

  const ApprovalItemDisplayModel({
    required this.title,
    required this.submittedBy,
    required this.icon,
    required this.buildingName,
    this.buildingRoomNumber,
    required this.assetType,
    required this.assetDescription,
    required this.statusText,
    required this.dateAdded,
    required this.lastUpdated,
  });
}


