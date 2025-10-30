class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String? department;
  final String? specialization;
  final String? hireDate;

  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    this.department,
    this.specialization,
    this.hireDate,
  });
}

