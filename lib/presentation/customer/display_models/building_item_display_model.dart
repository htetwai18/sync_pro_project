import 'package:sync_pro/config/app_string.dart';

class BuildingItemDisplayModel {
  final String id;
  final String name;
  final String address;
  final String? roomNumber;
  final String? status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const BuildingItemDisplayModel({
    required this.id,
    required this.name,
    required this.address,
    this.roomNumber,
    this.status,
    required this.createdAt,
    this.updatedAt,
  });
}

final List<BuildingItemDisplayModel> mockBuildings = [
  BuildingItemDisplayModel(
    id: 'B001',
    name: 'Headquarters',
    address: '123 Main St, San Francisco',
    createdAt: DateTime(2024, 1, 15),
  ),
  BuildingItemDisplayModel(
    id: 'B002',
    name: 'East Wing',
    address: '456 Oak Ave, San Francisco',
    status: AppString.pending,
    createdAt: DateTime(2024, 2, 10),
  ),
  BuildingItemDisplayModel(
    id: 'B003',
    name: 'West Campus',
    address: '789 Pine Ln, San Francisco',
    createdAt: DateTime(2024, 1, 20),
  ),
  BuildingItemDisplayModel(
    id: 'B004',
    name: 'Data Center',
    address: '101 Elm Rd, Oakland',
    createdAt: DateTime(2024, 3, 5),
  ),
  BuildingItemDisplayModel(
    id: 'B005',
    name: 'Warehouse Complex',
    address: '222 Maple Dr, San Jose',
    createdAt: DateTime(2024, 2, 28),
  ),
];
