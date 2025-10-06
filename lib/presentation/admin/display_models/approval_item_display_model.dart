// Data model for each item in the approval queue
import 'package:flutter/material.dart';

class ApprovalItemDisplayModel {
  final String title;
  final String submittedBy;
  final IconData icon;

  const ApprovalItemDisplayModel({
    required this.title,
    required this.submittedBy,
    required this.icon,
  });
}

/// Sample data to populate the list
/// will replace from api fetch later
List<ApprovalItemDisplayModel> approvalItems = const [
  ApprovalItemDisplayModel(
      title: 'New Building',
      submittedBy: 'Sarah Miller',
      icon: Icons.corporate_fare),
  ApprovalItemDisplayModel(
      title: 'New Room', submittedBy: 'David Chen', icon: Icons.meeting_room),
  ApprovalItemDisplayModel(
      title: 'New Asset', submittedBy: 'Emily Carter', icon: Icons.inventory_2),
  ApprovalItemDisplayModel(
      title: 'New Building',
      submittedBy: 'Michael Davis',
      icon: Icons.corporate_fare),
  ApprovalItemDisplayModel(
      title: 'New Room', submittedBy: 'Olivia Brown', icon: Icons.meeting_room),
  ApprovalItemDisplayModel(
      title: 'New Asset', submittedBy: 'Ethan Clark', icon: Icons.inventory_2),
];
