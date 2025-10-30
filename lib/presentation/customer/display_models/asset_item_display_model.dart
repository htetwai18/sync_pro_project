import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';

class AssetModel {
  final String id;
  final String name;
  final String manufacturer;
  final String model;
  final DateTime? installationDate;
  final BuildingModel building;

  const AssetModel({
    required this.id,
    required this.name,
    required this.manufacturer,
    required this.model,
    this.installationDate,
    required this.building,
  });
}

