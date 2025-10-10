class AssetItemDisplayModel {
  final String id;
  final String name;
  final String manufacturer;
  final String model;
  final String buildingId;
  final String buildingName;
  final String? buildingRoomNumber;
  final String address;
  final String? status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? installationDate;

  const AssetItemDisplayModel({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.model,
    required this.buildingId,
    required this.buildingName,
    this.buildingRoomNumber,
    this.status,
    required this.address,
    required this.createdAt,
    this.updatedAt,
    this.installationDate,
  });
}

final List<AssetItemDisplayModel> mockAssets = [
  AssetItemDisplayModel(
    id: 'A001',
    name: 'Server Rack',
    manufacturer: 'Dell',
    model: 'PowerEdge R740',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    address: '59th Street, Myo Thit, Lakraban, Bangkok, Thailand',
    createdAt: DateTime(2024, 1, 15),
    installationDate: DateTime(2022, 5, 15),
  ),
  AssetItemDisplayModel(
    id: 'A002',
    name: 'Network Switch',
    manufacturer: 'Cisco',
    model: 'Catalyst 9200',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    address: '59th Street, Myo Thit, Lakraban, Bangkok, Thailand',
    createdAt: DateTime(2024, 1, 16),
    installationDate: DateTime(2022, 6, 10),
  ),
  AssetItemDisplayModel(
    id: 'A003',
    name: 'UPS System',
    manufacturer: 'APC',
    model: 'Smart-UPS 3000VA',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    address: '59th Street, Myo Thit, Lakraban, Bangkok, Thailand',
    createdAt: DateTime(2024, 1, 17),
    installationDate: DateTime(2022, 7, 5),
  ),
  AssetItemDisplayModel(
    id: 'A004',
    name: 'Cooling Unit',
    manufacturer: 'Liebert',
    model: 'GXT4-100',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    address: '59th Street, Myo Thit, Lakraban, Bangkok, Thailand',
    createdAt: DateTime(2024, 1, 18),
    installationDate: DateTime(2022, 8, 12),
  ),
  AssetItemDisplayModel(
    id: 'A005',
    name: 'Firewall',
    manufacturer: 'Fortinet',
    model: 'FortiGate 200E',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    address: '59th Street, Myo Thit, Lakraban, Bangkok, Thailand',
    createdAt: DateTime(2024, 1, 19),
    installationDate: DateTime(2022, 9, 20),
  ),
  AssetItemDisplayModel(
    id: 'A006',
    name: 'Cabling',
    manufacturer: 'Belden',
    model: 'Cat6A',
    buildingId: 'B001',
    buildingName: 'Headquarters',
    buildingRoomNumber: 'R001',
    address: '59th Street, Myo Thit, Lakraban, Bangkok, Thailand',
    createdAt: DateTime(2024, 1, 20),
    installationDate: DateTime(2022, 10, 3),
  ),
];
