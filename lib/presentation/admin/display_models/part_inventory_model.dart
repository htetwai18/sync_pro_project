import 'package:sync_pro/presentation/admin/display_models/part_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/warehouse_display_model.dart';

class PartInventoryModel {
  final int quantityOnHand;
  final PartModel part;
  final InventoryModel location;

  const PartInventoryModel({
    required this.quantityOnHand,
    required this.part,
    required this.location,
  });
}