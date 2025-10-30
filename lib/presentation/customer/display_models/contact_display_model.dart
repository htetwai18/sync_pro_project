import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';

class ContactModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final CustomerModel customer;

  const ContactModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.customer,
  });
}
