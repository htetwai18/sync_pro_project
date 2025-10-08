class AssetItemDisplayModel {
  final String id;
  final String name;
  final String manufacturer;
  final String model;
  final String roomId;
  final String roomName;
  final String buildingId;
  final String buildingName;
  final String? status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AssetItemDisplayModel({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.roomId,
    required this.roomName,
    required this.buildingId,
    required this.buildingName,
    this.status,
    required this.createdAt,
    this.updatedAt,
  });
}

final List<AssetItemDisplayModel> mockAssets = [
  AssetItemDisplayModel(
    id: 'A001',
    name: 'Server Rack',
    manufacturer: 'Techtronics',
    model: 'X500',
    roomId: 'R001',
    roomName: 'Server Room A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    createdAt: DateTime(2024, 1, 15),
  ),
  AssetItemDisplayModel(
    id: 'A002',
    name: 'Network Switch',
    manufacturer: 'DataCore',
    model: '7200',
    roomId: 'R001',
    roomName: 'Server Room A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    createdAt: DateTime(2024, 1, 16),
  ),
  AssetItemDisplayModel(
    id: 'A003',
    name: 'UPS System',
    manufacturer: 'PowerGen',
    model: '1000W',
    roomId: 'R001',
    roomName: 'Server Room A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    createdAt: DateTime(2024, 1, 17),
  ),
  AssetItemDisplayModel(
    id: 'A004',
    name: 'Cooling Unit',
    manufacturer: 'CoolTech',
    model: '3000',
    roomId: 'R001',
    roomName: 'Server Room A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    createdAt: DateTime(2024, 1, 18),
  ),
  AssetItemDisplayModel(
    id: 'A005',
    name: 'Firewall',
    manufacturer: 'SecureNet',
    model: '2000',
    roomId: 'R001',
    roomName: 'Server Room A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    createdAt: DateTime(2024, 1, 19),
  ),
  AssetItemDisplayModel(
    id: 'A006',
    name: 'Cabling',
    manufacturer: 'CableCo',
    model: 'Cat6',
    roomId: 'R001',
    roomName: 'Server Room A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    createdAt: DateTime(2024, 1, 20),
  ),
];
