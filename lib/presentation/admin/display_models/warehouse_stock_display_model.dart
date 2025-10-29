class WarehouseStockDisplayModel {
  final String warehouseId;
  final String warehouseName;
  final String partId;
  final String partName;
  final int quantity;

  const WarehouseStockDisplayModel({
    required this.warehouseId,
    required this.warehouseName,
    required this.partId,
    required this.partName,
    required this.quantity,
  });

  WarehouseStockDisplayModel copyWith({int? quantity}) =>
      WarehouseStockDisplayModel(
        warehouseId: warehouseId,
        warehouseName: warehouseName,
        partId: partId,
        partName: partName,
        quantity: quantity ?? this.quantity,
      );
}

List<WarehouseStockDisplayModel> mockWarehouseStocks = [
  const WarehouseStockDisplayModel(
      warehouseId: 'W001',
      warehouseName: 'Warehouse A',
      partId: 'P001',
      partName: 'Widget A',
      quantity: 15),
  const WarehouseStockDisplayModel(
      warehouseId: 'W002',
      warehouseName: 'Engineer Van 5',
      partId: 'P001',
      partName: 'Widget A',
      quantity: 5),
];
