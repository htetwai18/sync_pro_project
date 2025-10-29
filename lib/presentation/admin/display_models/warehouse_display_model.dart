class WarehouseDisplayModel {
  final String id;
  final String name;
  final String code;
  final String? location;
  final String? contactName;
  final String? contactPhone;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const WarehouseDisplayModel({
    required this.id,
    required this.name,
    required this.code,
    this.location,
    this.contactName,
    this.contactPhone,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });
}

List<WarehouseDisplayModel> mockWarehouses = [
  WarehouseDisplayModel(
    id: 'W001',
    name: 'Warehouse A',
    code: 'WH-A',
    location: 'Downtown',
    contactName: 'Sarah Miller',
    contactPhone: '+1 555-111-2222',
    isActive: true,
    createdAt: DateTime(2024, 1, 10),
  ),
  WarehouseDisplayModel(
    id: 'W002',
    name: 'Engineer Van 5',
    code: 'VAN-5',
    location: 'Mobile',
    contactName: 'Daniel Lee',
    contactPhone: '+1 555-333-4444',
    isActive: true,
    createdAt: DateTime(2024, 3, 5),
  ),
];
