import 'package:sync_pro/presentation/admin/display_models/part_inventory_model.dart';


class PartModel {
  final String id;
  final String name;
  final String number;
  final String manufacturer;
  final double unitPrice;

  final List<PartInventoryModel>? stockLevels;

  const PartModel({
    required this.id,
    required this.name,
    required this.number,
    required this.manufacturer,
    required this.unitPrice,
    this.stockLevels,
  });
}

