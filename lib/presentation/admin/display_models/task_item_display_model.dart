import 'package:sync_pro/config/enum.dart';

class TaskItemDisplayModel {
  final String title;
  final String customer;
  final String assignedTo;
  final TaskStatus status;
  // Details
  final String description;
  final String assetId;
  final String assetName;
  final DateTime? createdAt;
  final DateTime? assignedAt;
  final DateTime? completedAt;

  const TaskItemDisplayModel({
    required this.title,
    required this.customer,
    required this.assignedTo,
    required this.status,
    this.description = '',
    this.assetId = '',
    this.assetName = '',
    this.createdAt,
    this.assignedAt,
    this.completedAt,
  });
}

final List<TaskItemDisplayModel> mockTasks = [
  TaskItemDisplayModel(
    title: 'Install New Server Rack',
    customer: 'Tech Solutions Inc.',
    assignedTo: 'Alex Johnson',
    status: TaskStatus.completed,
    description:
        'Install new HVAC system at 123 Main St. Includes wiring, ductwork, and thermostat setup. Ensure all connections are secure and system is functioning correctly before leaving.',
    assetId: '12345',
    assetName: 'HVAC System',
    createdAt: DateTime(2024, 1, 15, 10, 0),
    assignedAt: DateTime(2024, 1, 15, 11, 30),
    completedAt: DateTime(2024, 1, 16, 15, 45),
  ),
  TaskItemDisplayModel(
    title: 'Network Configuration',
    customer: 'DataStream Corp.',
    assignedTo: 'Maria Garcia',
    status: TaskStatus.inProgress,
  ),
  TaskItemDisplayModel(
    title: 'Software Upgrade',
    customer: 'CloudNine Services',
    assignedTo: 'David Chen',
    status: TaskStatus.overdue,
  ),
  TaskItemDisplayModel(
    title: 'Security Audit',
    customer: 'SecureNet Systems',
    assignedTo: 'Emily White',
    status: TaskStatus.notStarted,
  ),
  TaskItemDisplayModel(
    title: 'System Maintenance',
    customer: 'Innovate Solutions',
    assignedTo: 'Michael Brown',
    status: TaskStatus.completed,
  ),
  TaskItemDisplayModel(
    title: 'Data Migration',
    customer: 'Global Tech Group',
    assignedTo: 'Sarah Lee',
    status: TaskStatus.inProgress,
  ),
];
