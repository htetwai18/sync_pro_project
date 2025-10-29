import 'package:sync_pro/config/app_string.dart';

class ContactDisplayModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role; // Use AppString roles for now

  const ContactDisplayModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });
}

// Mock contacts
const List<ContactDisplayModel> mockContacts = [
  ContactDisplayModel(
    id: 'C001',
    name: AppString.aliceJohnson,
    email: 'alice.johnson@example.com',
    phone: '+1 555-111-2222',
    role: AppString.manager,
  ),
  ContactDisplayModel(
    id: 'C002',
    name: AppString.bobWilliams,
    email: 'bob.williams@example.com',
    phone: '+1 555-333-4444',
    role: AppString.engineerContact,
  ),
  ContactDisplayModel(
    id: 'C003',
    name: AppString.charlieDavis,
    email: 'charlie.davis@example.com',
    phone: '+1 555-777-8888',
    role: AppString.technician,
  ),
];
