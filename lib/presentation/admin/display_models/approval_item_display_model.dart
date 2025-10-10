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

/// Sample data to populate the list
/// will replace from api fetch later
List<ApprovalItemDisplayModel> approvalItems = const [
  ApprovalItemDisplayModel(
    title: 'New Building',
    submittedBy: 'Sarah Miller',
    icon: Icons.corporate_fare,
    buildingName: 'Corporate Headquarters',
    buildingRoomNumber: '1402',
    assetType: 'HVAC Unit',
    assetDescription: 'Model #ABC-123, Serial #XYZ-987',
    statusText: 'Pending Approval',
    dateAdded: '2024-07-22',
    lastUpdated: '2024-07-22',
  ),
  ApprovalItemDisplayModel(
    title: 'New Building',
    submittedBy: 'David Chen',
    icon: Icons.meeting_room,
    buildingName: 'West Campus',
    buildingRoomNumber: 'B12',
    assetType: 'Building',
    assetDescription: 'Conference room renovation',
    statusText: 'Pending Approval',
    dateAdded: '2024-07-21',
    lastUpdated: '2024-07-22',
  ),
  ApprovalItemDisplayModel(
    title: 'New Asset',
    submittedBy: 'Emily Carter',
    icon: Icons.inventory_2,
    buildingName: 'R&D Center',
    buildingRoomNumber: '220',
    assetType: '3D Printer',
    assetDescription: 'Model Mark X7',
    statusText: 'Pending Approval',
    dateAdded: '2024-07-20',
    lastUpdated: '2024-07-21',
  ),
];
