import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/building_item_display_model.dart';
import 'package:sync_pro/presentation/customer/display_models/contact_display_model.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final List<ContactModel>? contacts;
  final List<BuildingModel>? buildings;
  final List<InvoiceModel>? invoices;

  const CustomerModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.contacts,
    this.buildings,
    this.invoices,
  });
}

