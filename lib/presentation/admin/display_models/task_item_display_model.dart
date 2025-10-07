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
  // Shared/engineer-only
  final String address;
  final DateTime? scheduledAt;
  final bool isCompleted;
  final int notifications;

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
    this.address = '',
    this.scheduledAt,
    this.isCompleted = false,
    this.notifications = 0,
  });
}

final List<TaskItemDisplayModel> mockTasks = [
  // Today (not completed)
  TaskItemDisplayModel(
    title: 'Install New Server',
    customer: 'CyberCorp Inc.',
    assignedTo: 'Alex Johnson',
    status: TaskStatus.notStarted,
    description:
        'Install new server hardware at the client site. Verify rack space, power, and network connectivity.',
    address: '123 Main St, Anytown',
    scheduledAt: DateTime.now(),
    notifications: 2,
  ),
  TaskItemDisplayModel(
    title: 'Network Troubleshooting',
    customer: 'Innovate Solutions',
    assignedTo: 'Maria Garcia',
    status: TaskStatus.inProgress,
    description:
        'Investigate intermittent connectivity issues on the 2nd floor office and restore stable service.',
    address: '456 Oak Ave, Anytown',
    scheduledAt: DateTime.now(),
  ),
  // Upcoming
  TaskItemDisplayModel(
    title: 'Software Upgrade',
    customer: 'DataFlow Systems',
    assignedTo: 'David Chen',
    status: TaskStatus.notStarted,
    description:
        'Upgrade ERP application to v5.2. Ensure backups and validate post-upgrade checks.',
    address: '789 Pine Ln, Anytown',
    scheduledAt: DateTime.now().add(const Duration(days: 2)),
    notifications: 1,
  ),
  // Completed (yesterday)
  TaskItemDisplayModel(
    title: 'Firewall Review',
    customer: 'SecureTech',
    assignedTo: 'Emily White',
    status: TaskStatus.completed,
    description:
        'Audit firewall rules and remove deprecated policies. Provide report to IT manager.',
    address: '22 Center Rd, Anytown',
    scheduledAt: DateTime.now().subtract(const Duration(days: 1)),
    isCompleted: true,
    completedAt: DateTime.now().subtract(const Duration(hours: 6)),
  ),
  // More data for list feel
  TaskItemDisplayModel(
    title: 'System Maintenance',
    customer: 'Innovate Solutions',
    assignedTo: 'Michael Brown',
    status: TaskStatus.completed,
    address: '88 Hill St, Anytown',
    scheduledAt: DateTime.now().subtract(const Duration(days: 3)),
    isCompleted: true,
  ),
  TaskItemDisplayModel(
    title: 'Data Migration',
    customer: 'Global Tech Group',
    assignedTo: 'Sarah Lee',
    status: TaskStatus.inProgress,
    address: '101 River Rd, Anytown',
    scheduledAt: DateTime.now().add(const Duration(days: 1)),
  ),
];
