import 'package:flutter/material.dart';

class ReportItemDisplayModel {
  final String title;
  final String customer;
  final String author;
  final String date; // ISO-like string for now
  final IconData icon;

  const ReportItemDisplayModel({
    required this.title,
    required this.customer,
    required this.author,
    required this.date,
    required this.icon,
  });
}

const List<ReportItemDisplayModel> mockReports = [
  ReportItemDisplayModel(
    title: 'Task: Network Upgrade',
    customer: 'Tech Solutions Inc.',
    author: 'Alex Johnson',
    date: '07/22/2024',
    icon: Icons.description,
  ),
  ReportItemDisplayModel(
    title: 'Task: Server Maintenance',
    customer: 'Global Innovations Ltd.',
    author: 'Sarah Williams',
    date: '07/21/2024',
    icon: Icons.description,
  ),
  ReportItemDisplayModel(
    title: 'Task: System Integration',
    customer: 'Future Dynamics Corp.',
    author: 'Michael Brown',
    date: '07/20/2024',
    icon: Icons.description,
  ),
  ReportItemDisplayModel(
    title: 'Task: Software Installation',
    customer: 'Apex Industries LLC',
    author: 'Emily Davis',
    date: '07/19/2024',
    icon: Icons.description,
  ),
  ReportItemDisplayModel(
    title: 'Task: Hardware Repair',
    customer: 'Quantum Systems Inc.',
    author: 'David Lee',
    date: '07/18/2024',
    icon: Icons.description,
  ),
];
