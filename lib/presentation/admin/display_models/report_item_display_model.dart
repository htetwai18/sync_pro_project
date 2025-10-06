import 'package:flutter/material.dart';

class ReportItemDisplayModel {
  final String title;
  final String customer;
  final String author;
  final String date; // ISO-like string for now
  // Detail fields
  final String content;
  final List<String> attachmentUrls;
  final String taskId;
  final String status;

  const ReportItemDisplayModel({
    required this.title,
    required this.customer,
    required this.author,
    required this.date,
    required this.content,
    required this.attachmentUrls,
    required this.taskId,
    required this.status,
  });
}

const List<ReportItemDisplayModel> mockReports = [
  ReportItemDisplayModel(
    title: 'Task: Network Upgrade',
    customer: 'Tech Solutions Inc.',
    author: 'Alex Johnson',
    date: '07/22/2024',
    content:
        'The installation of the new server rack was completed successfully. All systems are functioning as expected, and the network connectivity has been verified. The client expressed satisfaction with the work.',
    attachmentUrls: [
      'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=1200',
    ],
    taskId: '#12340',
    status: 'Completed',
  ),
  ReportItemDisplayModel(
    title: 'Task: Server Maintenance',
    customer: 'Global Innovations Ltd.',
    author: 'Sarah Williams',
    date: '07/21/2024',
    content:
        'Performed scheduled maintenance on servers. Replaced failing disk and updated firmware. All systems nominal.',
    attachmentUrls: [
      'https://images.unsplash.com/photo-1585079542156-2755d9b66b1e?w=800',
    ],
    taskId: '#12341',
    status: 'Completed',
  ),
  ReportItemDisplayModel(
    title: 'Task: System Integration',
    customer: 'Future Dynamics Corp.',
    author: 'Michael Brown',
    date: '07/20/2024',
    content:
        'Integrated new CRM with existing ERP. Validated data flows and trained staff.',
    attachmentUrls: [],
    taskId: '#12342',
    status: 'Pending Review',
  ),
  ReportItemDisplayModel(
    title: 'Task: Software Installation',
    customer: 'Apex Industries LLC',
    author: 'Emily Davis',
    date: '07/19/2024',
    content: 'Installed licensed software suite and configured user roles.',
    attachmentUrls: [],
    taskId: '#12343',
    status: 'Completed',
  ),
  ReportItemDisplayModel(
    title: 'Task: Hardware Repair',
    customer: 'Quantum Systems Inc.',
    author: 'David Lee',
    date: '07/18/2024',
    content: 'Replaced power supply unit and validated thermal performance.',
    attachmentUrls: [],
    taskId: '#12345',
    status: 'Completed',
  ),
];
