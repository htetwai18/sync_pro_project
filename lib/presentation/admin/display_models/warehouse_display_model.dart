class InventoryModel {
  final String id;
  final String name;
  final String code;
  final String? contactName;
  final String? contactPhone;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const InventoryModel({
    required this.id,
    required this.name,
    required this.code,
    this.contactName,
    this.contactPhone,
    this.isActive = true,
    required this.createdAt,
    this.updatedAt,
  });
}

