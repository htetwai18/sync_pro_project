import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/enum.dart';

enum TaskPriority {
  low,
  medium,
  high,
  urgent,
}

enum TaskType {
  maintenance,
  repair,
  installation,
  inspection,
  emergency,
  other,
}

class TaskDisplayModel {
  final String id;
  final String title;
  final String description;
  final TaskType type;
  final TaskPriority priority;
  final TaskStatus status;
  final String buildingId;
  final String buildingName;
  final String? buildingRoomNumber;
  final String? assetId;
  final String? assetName;
  final DateTime requestDate;
  final DateTime? preferredDate;
  final String? preferredTime;
  final String? specialInstructions;
  final String? assignedEngineer;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final String? notes;
  final String? customerName;
  final String? address;
  final DateTime? assignedAt;

  const TaskDisplayModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.status,
    required this.buildingId,
    required this.buildingName,
    this.buildingRoomNumber,
    this.assetId,
    this.assetName,
    required this.requestDate,
    this.preferredDate,
    this.preferredTime,
    this.specialInstructions,
    this.assignedEngineer,
    this.scheduledDate,
    this.completedDate,
    this.notes,
    this.customerName,
    this.address,
    this.assignedAt,
  });
}

// Mock data for tasks
final List<TaskDisplayModel> mockTasks = [
  TaskDisplayModel(
    id: 'SR001',
    title: 'Air Conditioner Maintenance',
    description:
        'Regular maintenance and cleaning of AC unit in conference room',
    type: TaskType.maintenance,
    priority: TaskPriority.medium,
    status: TaskStatus.notStarted,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    assetId: 'A001',
    assetName: 'Daikin AC Unit',
    requestDate: DateTime(2024, 1, 15),
    preferredDate: DateTime(2024, 1, 20),
    preferredTime: '10:00 AM',
    specialInstructions: 'Please bring replacement filters',
    assignedEngineer: 'Alice Johnson',
    scheduledDate: DateTime(2024, 1, 20, 10, 0),
    customerName: 'John Smith',
    address: '123 Main Street, Yangon',
    assignedAt: DateTime(2024, 1, 15),
  ),
  TaskDisplayModel(
    id: 'SR002',
    title: 'Generator Repair',
    description: 'Generator not starting, needs immediate repair',
    type: TaskType.repair,
    priority: TaskPriority.high,
    status: TaskStatus.inProgress,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R002',
    assetId: 'A002',
    assetName: 'Honda GX390 Generator',
    requestDate: DateTime(2024, 1, 16),
    preferredDate: DateTime(2024, 1, 17),
    preferredTime: '9:00 AM',
    specialInstructions: 'Emergency repair needed',
    assignedEngineer: 'Bob Williams',
    scheduledDate: DateTime(2024, 1, 17, 9, 0),
    customerName: 'Global Industries Ltd.',
    address: '456 Industrial Zone, Mandalay',
    assignedAt: DateTime(2024, 1, 16),
  ),
  TaskDisplayModel(
    id: 'SR003',
    title: 'Solar Panel Installation',
    description: 'Install new solar panels on rooftop',
    type: TaskType.installation,
    priority: TaskPriority.medium,
    status: TaskStatus.completed,
    buildingId: 'B002',
    buildingName: 'East Wing',
    buildingRoomNumber: null,
    assetId: 'A003',
    assetName: 'SunPower 400W Panel',
    requestDate: DateTime(2024, 1, 10),
    preferredDate: DateTime(2024, 1, 15),
    preferredTime: '8:00 AM',
    specialInstructions: 'Weather dependent installation',
    assignedEngineer: 'Charlie Kim',
    scheduledDate: DateTime(2024, 1, 15, 8, 0),
    completedDate: DateTime(2024, 1, 15, 16, 0),
    notes:
        'Installation completed successfully. All panels tested and working.',
    customerName: 'Green Energy Co.',
    address: '789 Energy Street, Naypyidaw',
    assignedAt: DateTime(2024, 1, 10),
  ),
  TaskDisplayModel(
    id: 'SR004',
    title: 'Water Pump Inspection',
    description: 'Monthly inspection of water pump system',
    type: TaskType.inspection,
    priority: TaskPriority.low,
    status: TaskStatus.completed,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R003',
    assetId: 'A004',
    assetName: 'Grundfos Pump',
    requestDate: DateTime(2024, 1, 5),
    preferredDate: DateTime(2024, 1, 12),
    preferredTime: '2:00 PM',
    assignedEngineer: 'Alice Johnson',
    scheduledDate: DateTime(2024, 1, 12, 14, 0),
    completedDate: DateTime(2024, 1, 12, 15, 30),
    notes: 'Pump system in good condition. No issues found.',
    customerName: 'AquaPure Ltd.',
    address: '222 River Road, Yangon',
    assignedAt: DateTime(2024, 1, 5),
  ),
  TaskDisplayModel(
    id: 'SR005',
    title: 'Elevator Emergency Repair',
    description: 'Elevator stuck between floors, emergency repair needed',
    type: TaskType.emergency,
    priority: TaskPriority.urgent,
    status: TaskStatus.inProgress,
    buildingId: 'B003',
    buildingName: 'West Campus',
    buildingRoomNumber: null,
    assetId: 'A005',
    assetName: 'Otis Elevator',
    requestDate: DateTime(2024, 1, 18),
    preferredDate: DateTime(2024, 1, 18),
    preferredTime: 'Immediate',
    specialInstructions: 'URGENT: People trapped in elevator',
    assignedEngineer: 'Daniel Lee',
    scheduledDate: DateTime(2024, 1, 18, 11, 0),
    customerName: 'Sky Tower Apartments',
    address: '15 Tower Street, Yangon',
    assignedAt: DateTime(2024, 1, 18),
  ),
  TaskDisplayModel(
    id: 'SR006',
    title: 'Lighting System Upgrade',
    description: 'Upgrade lighting system to LED for energy efficiency',
    type: TaskType.installation,
    priority: TaskPriority.medium,
    status: TaskStatus.notStarted,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R004',
    assetId: 'A006',
    assetName: 'Philips LED System',
    requestDate: DateTime(2024, 1, 17),
    preferredDate: DateTime(2024, 1, 25),
    preferredTime: '9:00 AM',
    specialInstructions: 'Need approval for budget before proceeding',
    customerName: 'City Mall Yangon',
    address: '88 Central Road, Yangon',
    assignedAt: DateTime(2024, 1, 17),
  ),
  TaskDisplayModel(
    id: 'SR007',
    title: 'Boiler Pressure Test',
    description: 'Annual pressure test and safety valve inspection',
    type: TaskType.inspection,
    priority: TaskPriority.high,
    status: TaskStatus.completed,
    buildingId: 'B004',
    buildingName: 'Data Center',
    buildingRoomNumber: 'R005',
    assetId: 'A007',
    assetName: 'Thermax Boiler',
    requestDate: DateTime(2024, 1, 8),
    preferredDate: DateTime(2024, 1, 14),
    preferredTime: '10:00 AM',
    assignedEngineer: 'Charlie Kim',
    scheduledDate: DateTime(2024, 1, 14, 10, 0),
    completedDate: DateTime(2024, 1, 14, 12, 0),
    notes:
        'All safety tests passed. Boiler operating within normal parameters.',
    customerName: 'Yangon Textile Co.',
    address: '77 Factory Zone, Yangon',
    assignedAt: DateTime(2024, 1, 8),
  ),
  TaskDisplayModel(
    id: 'SR008',
    title: 'HVAC Filter Replacement',
    description: 'Replace all air filters and clean ducts',
    type: TaskType.maintenance,
    priority: TaskPriority.low,
    status: TaskStatus.notStarted,
    buildingId: 'B002',
    buildingName: 'East Wing',
    buildingRoomNumber: 'R006',
    assetId: 'A008',
    assetName: 'LG HVAC System',
    requestDate: DateTime(2024, 1, 19),
    preferredDate: DateTime(2024, 1, 22),
    preferredTime: '11:00 AM',
    specialInstructions: 'Bring replacement filters for all units',
    assignedEngineer: 'Bob Williams',
    scheduledDate: DateTime(2024, 1, 22, 11, 0),
    customerName: 'Shwe Hospital',
    address: 'Health Road, Yangon',
    assignedAt: DateTime(2024, 1, 19),
  ),
];

// Helper functions to get display strings
String getTaskStatusText(TaskStatus status) {
  switch (status) {
    case TaskStatus.notStarted:
      return AppString.pending;
    case TaskStatus.inProgress:
      return AppString.inProgress;
    case TaskStatus.completed:
      return AppString.completed;
    case TaskStatus.overdue:
      return AppString.overdue;
  }
}

String getTaskPriorityText(TaskPriority priority) {
  switch (priority) {
    case TaskPriority.low:
      return AppString.low;
    case TaskPriority.medium:
      return AppString.medium;
    case TaskPriority.high:
      return AppString.high;
    case TaskPriority.urgent:
      return AppString.urgent;
  }
}

String getTaskTypeText(TaskType type) {
  switch (type) {
    case TaskType.maintenance:
      return AppString.maintenance;
    case TaskType.repair:
      return AppString.repair;
    case TaskType.installation:
      return AppString.installation;
    case TaskType.inspection:
      return AppString.inspection;
    case TaskType.emergency:
      return AppString.emergency;
    case TaskType.other:
      return AppString.other;
  }
}
