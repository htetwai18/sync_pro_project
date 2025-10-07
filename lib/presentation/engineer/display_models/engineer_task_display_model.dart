class EngineerTaskDisplayModel {
  final String title;
  final String customer;
  final String address;
  final String statusLabel;
  final DateTime scheduledAt;
  final bool isCompleted;

  const EngineerTaskDisplayModel({
    required this.title,
    required this.customer,
    required this.address,
    required this.statusLabel,
    required this.scheduledAt,
    this.isCompleted = false,
  });
}

final List<EngineerTaskDisplayModel> engineerTasks = [
  EngineerTaskDisplayModel(
    title: 'Install New Server',
    customer: 'CyberCorp Inc.',
    address: '123 Main St, Anytown',
    statusLabel: 'En Route',
    scheduledAt: DateTime.now(),
  ),
  EngineerTaskDisplayModel(
    title: 'Network Troubleshooting',
    customer: 'Innovate Solutions',
    address: '456 Oak Ave, Anytown',
    statusLabel: 'On Site',
    scheduledAt: DateTime.now(),
  ),
  EngineerTaskDisplayModel(
    title: 'Software Upgrade',
    customer: 'DataFlow Systems',
    address: '789 Pine Ln, Anytown',
    statusLabel: 'Parts Needed',
    scheduledAt: DateTime.now().add(const Duration(days: 2)),
  ),
  EngineerTaskDisplayModel(
    title: 'Firewall Review',
    customer: 'SecureTech',
    address: '22 Center Rd',
    statusLabel: 'Completed',
    scheduledAt: DateTime.now().subtract(const Duration(days: 1)),
    isCompleted: true,
  ),
];
