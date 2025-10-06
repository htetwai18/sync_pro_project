import 'package:sync_pro/config/enum.dart';

class TaskItemDisplayModel {
  final String title;
  final String customer;
  final String assignedTo;
  final TaskStatus status;

  const TaskItemDisplayModel({
    required this.title,
    required this.customer,
    required this.assignedTo,
    required this.status,
  });
}

const List<TaskItemDisplayModel> mockTasks = [
  TaskItemDisplayModel(
    title: 'Install New Server Rack',
    customer: 'Tech Solutions Inc.',
    assignedTo: 'Alex Johnson',
    status: TaskStatus.completed,
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
