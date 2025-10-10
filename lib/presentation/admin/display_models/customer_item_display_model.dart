class CustomerItemDisplayModel {
  final String name;
  final String phone;

  const CustomerItemDisplayModel({required this.name, required this.phone});
}

const List<CustomerItemDisplayModel> mockCustomers = [
  CustomerItemDisplayModel(name: 'Acme Corp', phone: '(555) 123-4567'),
  CustomerItemDisplayModel(
      name: 'Tech Solutions Inc.', phone: '(555) 987-6543'),
  CustomerItemDisplayModel(name: 'Global Innovations', phone: '(555) 246-8013'),
  CustomerItemDisplayModel(name: 'Dynamic Systems', phone: '(555) 135-7924'),
  CustomerItemDisplayModel(
      name: 'Pinnacle Enterprises', phone: '(555) 369-1212'),
];
