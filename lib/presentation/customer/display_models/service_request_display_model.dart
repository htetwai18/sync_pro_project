import 'package:sync_pro/config/app_string.dart';

enum ServiceRequestStatus {
  pending,
  scheduled,
  inProgress,
  completed,
  cancelled,
  onHold,
  awaitingApproval,
}

enum ServiceRequestPriority {
  low,
  medium,
  high,
  urgent,
}

enum ServiceRequestType {
  maintenance,
  repair,
  installation,
  inspection,
  emergency,
  other,
}

class ServiceRequestDisplayModel {
  final String id;
  final String title;
  final String description;
  final ServiceRequestType type;
  final ServiceRequestPriority priority;
  final ServiceRequestStatus status;
  final String buildingId;
  final String buildingName;
  final String? roomNumber;
  final String? assetId;
  final String? assetName;
  final String contactPerson;
  final String contactPhone;
  final DateTime requestDate;
  final DateTime? preferredDate;
  final String? preferredTime;
  final String? specialInstructions;
  final String? assignedEngineer;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final String? notes;

  const ServiceRequestDisplayModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.status,
    required this.buildingId,
    required this.buildingName,
    this.roomNumber,
    this.assetId,
    this.assetName,
    required this.contactPerson,
    required this.contactPhone,
    required this.requestDate,
    this.preferredDate,
    this.preferredTime,
    this.specialInstructions,
    this.assignedEngineer,
    this.scheduledDate,
    this.completedDate,
    this.notes,
  });
}

// Mock data for service requests
final List<ServiceRequestDisplayModel> mockServiceRequests = [
  ServiceRequestDisplayModel(
    id: 'SR001',
    title: 'Air Conditioner Maintenance',
    description:
        'Regular maintenance and cleaning of AC unit in conference room',
    type: ServiceRequestType.maintenance,
    priority: ServiceRequestPriority.medium,
    status: ServiceRequestStatus.scheduled,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    roomNumber: 'R001',
    assetId: 'A001',
    assetName: 'Daikin AC Unit',
    contactPerson: 'John Smith',
    contactPhone: '+1 (555) 123-4567',
    requestDate: DateTime(2024, 1, 15),
    preferredDate: DateTime(2024, 1, 20),
    preferredTime: '10:00 AM',
    specialInstructions: 'Please bring replacement filters',
    assignedEngineer: 'Alice Johnson',
    scheduledDate: DateTime(2024, 1, 20, 10, 0),
  ),
  ServiceRequestDisplayModel(
    id: 'SR002',
    title: 'Generator Repair',
    description: 'Generator not starting, needs immediate repair',
    type: ServiceRequestType.repair,
    priority: ServiceRequestPriority.high,
    status: ServiceRequestStatus.inProgress,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    roomNumber: 'R002',
    assetId: 'A002',
    assetName: 'Honda GX390 Generator',
    contactPerson: 'Sarah Wilson',
    contactPhone: '+1 (555) 234-5678',
    requestDate: DateTime(2024, 1, 16),
    preferredDate: DateTime(2024, 1, 17),
    preferredTime: '9:00 AM',
    specialInstructions: 'Emergency repair needed',
    assignedEngineer: 'Bob Williams',
    scheduledDate: DateTime(2024, 1, 17, 9, 0),
  ),
  ServiceRequestDisplayModel(
    id: 'SR003',
    title: 'Solar Panel Installation',
    description: 'Install new solar panels on rooftop',
    type: ServiceRequestType.installation,
    priority: ServiceRequestPriority.medium,
    status: ServiceRequestStatus.completed,
    buildingId: 'B002',
    buildingName: 'East Wing',
    roomNumber: null,
    assetId: 'A003',
    assetName: 'SunPower 400W Panel',
    contactPerson: 'Mike Davis',
    contactPhone: '+1 (555) 345-6789',
    requestDate: DateTime(2024, 1, 10),
    preferredDate: DateTime(2024, 1, 15),
    preferredTime: '8:00 AM',
    specialInstructions: 'Weather dependent installation',
    assignedEngineer: 'Charlie Kim',
    scheduledDate: DateTime(2024, 1, 15, 8, 0),
    completedDate: DateTime(2024, 1, 15, 16, 0),
    notes:
        'Installation completed successfully. All panels tested and working.',
  ),
  ServiceRequestDisplayModel(
    id: 'SR004',
    title: 'Water Pump Inspection',
    description: 'Monthly inspection of water pump system',
    type: ServiceRequestType.inspection,
    priority: ServiceRequestPriority.low,
    status: ServiceRequestStatus.completed,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    roomNumber: 'R003',
    assetId: 'A004',
    assetName: 'Grundfos Pump',
    contactPerson: 'Lisa Brown',
    contactPhone: '+1 (555) 456-7890',
    requestDate: DateTime(2024, 1, 5),
    preferredDate: DateTime(2024, 1, 12),
    preferredTime: '2:00 PM',
    assignedEngineer: 'Alice Johnson',
    scheduledDate: DateTime(2024, 1, 12, 14, 0),
    completedDate: DateTime(2024, 1, 12, 15, 30),
    notes: 'Pump system in good condition. No issues found.',
  ),
  ServiceRequestDisplayModel(
    id: 'SR005',
    title: 'Elevator Emergency Repair',
    description: 'Elevator stuck between floors, emergency repair needed',
    type: ServiceRequestType.emergency,
    priority: ServiceRequestPriority.urgent,
    status: ServiceRequestStatus.inProgress,
    buildingId: 'B003',
    buildingName: 'West Campus',
    roomNumber: null,
    assetId: 'A005',
    assetName: 'Otis Elevator',
    contactPerson: 'Tom Wilson',
    contactPhone: '+1 (555) 567-8901',
    requestDate: DateTime(2024, 1, 18),
    preferredDate: DateTime(2024, 1, 18),
    preferredTime: 'Immediate',
    specialInstructions: 'URGENT: People trapped in elevator',
    assignedEngineer: 'Daniel Lee',
    scheduledDate: DateTime(2024, 1, 18, 11, 0),
  ),
  ServiceRequestDisplayModel(
    id: 'SR006',
    title: 'Lighting System Upgrade',
    description: 'Upgrade lighting system to LED for energy efficiency',
    type: ServiceRequestType.installation,
    priority: ServiceRequestPriority.medium,
    status: ServiceRequestStatus.awaitingApproval,
    buildingId: 'B001',
    buildingName: 'Headquarters',
    roomNumber: 'R004',
    assetId: 'A006',
    assetName: 'Philips LED System',
    contactPerson: 'Jane Smith',
    contactPhone: '+1 (555) 678-9012',
    requestDate: DateTime(2024, 1, 17),
    preferredDate: DateTime(2024, 1, 25),
    preferredTime: '9:00 AM',
    specialInstructions: 'Need approval for budget before proceeding',
  ),
  ServiceRequestDisplayModel(
    id: 'SR007',
    title: 'Boiler Pressure Test',
    description: 'Annual pressure test and safety valve inspection',
    type: ServiceRequestType.inspection,
    priority: ServiceRequestPriority.high,
    status: ServiceRequestStatus.completed,
    buildingId: 'B004',
    buildingName: 'Data Center',
    roomNumber: 'R005',
    assetId: 'A007',
    assetName: 'Thermax Boiler',
    contactPerson: 'Robert Johnson',
    contactPhone: '+1 (555) 789-0123',
    requestDate: DateTime(2024, 1, 8),
    preferredDate: DateTime(2024, 1, 14),
    preferredTime: '10:00 AM',
    assignedEngineer: 'Charlie Kim',
    scheduledDate: DateTime(2024, 1, 14, 10, 0),
    completedDate: DateTime(2024, 1, 14, 12, 0),
    notes:
        'All safety tests passed. Boiler operating within normal parameters.',
  ),
  ServiceRequestDisplayModel(
    id: 'SR008',
    title: 'HVAC Filter Replacement',
    description: 'Replace all air filters and clean ducts',
    type: ServiceRequestType.maintenance,
    priority: ServiceRequestPriority.low,
    status: ServiceRequestStatus.scheduled,
    buildingId: 'B002',
    buildingName: 'East Wing',
    roomNumber: 'R006',
    assetId: 'A008',
    assetName: 'LG HVAC System',
    contactPerson: 'Mary Davis',
    contactPhone: '+1 (555) 890-1234',
    requestDate: DateTime(2024, 1, 19),
    preferredDate: DateTime(2024, 1, 22),
    preferredTime: '11:00 AM',
    specialInstructions: 'Bring replacement filters for all units',
    assignedEngineer: 'Bob Williams',
    scheduledDate: DateTime(2024, 1, 22, 11, 0),
  ),
];

// Helper functions to get display strings
String getServiceRequestStatusText(ServiceRequestStatus status) {
  switch (status) {
    case ServiceRequestStatus.pending:
      return AppString.pending;
    case ServiceRequestStatus.scheduled:
      return AppString.scheduled;
    case ServiceRequestStatus.inProgress:
      return AppString.inProgress;
    case ServiceRequestStatus.completed:
      return AppString.completed;
    case ServiceRequestStatus.cancelled:
      return AppString.cancelled;
    case ServiceRequestStatus.onHold:
      return AppString.onHold;
    case ServiceRequestStatus.awaitingApproval:
      return AppString.awaitingApproval;
  }
}

String getServiceRequestPriorityText(ServiceRequestPriority priority) {
  switch (priority) {
    case ServiceRequestPriority.low:
      return AppString.low;
    case ServiceRequestPriority.medium:
      return AppString.medium;
    case ServiceRequestPriority.high:
      return AppString.high;
    case ServiceRequestPriority.urgent:
      return AppString.urgent;
  }
}

String getServiceRequestTypeText(ServiceRequestType type) {
  switch (type) {
    case ServiceRequestType.maintenance:
      return AppString.maintenance;
    case ServiceRequestType.repair:
      return AppString.repair;
    case ServiceRequestType.installation:
      return AppString.installation;
    case ServiceRequestType.inspection:
      return AppString.inspection;
    case ServiceRequestType.emergency:
      return AppString.emergency;
    case ServiceRequestType.other:
      return AppString.other;
  }
}
