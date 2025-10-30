import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/asset_item_display_model.dart';

class BuildingModel {
  final String id;
  final String name;
  final String address;
  final String? roomNumber;
  final CustomerModel customer;
  final List<AssetModel>? assets;

  const BuildingModel({
    required this.id,
    required this.name,
    required this.address,
    this.roomNumber,
    required this.customer,
    this.assets,
  });
}
