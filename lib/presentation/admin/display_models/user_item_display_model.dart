import 'package:sync_pro/config/app_string.dart';
import 'package:sync_pro/config/enum.dart';

class UserItemDisplayModel {
  final String name;
  final String email;
  final UserRole role;
  final String avatarUrl;
  // detail fields
  final String id;
  final String phone;
  final String department;
  final String status;
  final String location;
  final String hireDate;
  final String lastLogin;

  const UserItemDisplayModel({
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
    this.id = '12345',
    this.phone = '(555) 123-4567',
    this.department = 'Operations',
    this.status = 'Active',
    this.location = 'New York',
    this.hireDate = '2022-08-15',
    this.lastLogin = '2024-07-20 10:30 AM',
  });

  String get roleLabel {
    switch (role) {
      case UserRole.admin:
        return AppString.adminRole;
      case UserRole.engineer:
        return AppString.engineerRole;
      case UserRole.manager:
        return AppString.managerRole;
    }
  }
}

final List<UserItemDisplayModel> mockUsers = [
  const UserItemDisplayModel(
    name: 'Alice Johnson',
    email: 'alice.johnson@example.com',
    role: UserRole.admin,
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
  ),
  const UserItemDisplayModel(
    name: 'Bob Williams',
    email: 'bob.williams@example.com',
    role: UserRole.engineer,
    avatarUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
  ),
  const UserItemDisplayModel(
    name: 'Charlie Davis',
    email: 'charlie.davis@example.com',
    role: UserRole.engineer,
    avatarUrl:
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
  ),
  const UserItemDisplayModel(
    name: 'Diana Miller',
    email: 'diana.miller@example.com',
    role: UserRole.manager,
    avatarUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
  ),
  const UserItemDisplayModel(
    name: 'Edward Taylor',
    email: 'edward.taylor@example.com',
    role: UserRole.engineer,
    avatarUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
  ),
  const UserItemDisplayModel(
    name: 'Fiona Clark',
    email: 'fiona.clark@example.com',
    role: UserRole.admin,
    avatarUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150',
  ),
];
