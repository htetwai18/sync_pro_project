import 'package:sync_pro/config/enum.dart';

class InvoiceItemDisplayModel {
  final String id;
  final String customer;
  final String dueDate; // formatted
  final double amount;
  final InvoiceStatus status;

  const InvoiceItemDisplayModel({
    required this.id,
    required this.customer,
    required this.dueDate,
    required this.amount,
    required this.status,
  });
}

final List<InvoiceItemDisplayModel> mockInvoices = [
  const InvoiceItemDisplayModel(
    id: '2024001',
    customer: 'Tech Solutions Inc.',
    dueDate: '25 Aug 2024',
    amount: 1250.00,
    status: InvoiceStatus.paid,
  ),
  const InvoiceItemDisplayModel(
    id: '2024002',
    customer: 'Global Innovations Ltd.',
    dueDate: '15 Sep 2024',
    amount: 3500.00,
    status: InvoiceStatus.sent,
  ),
  const InvoiceItemDisplayModel(
    id: '2024003',
    customer: 'Apex Dynamics',
    dueDate: '10 Sep 2024',
    amount: 800.00,
    status: InvoiceStatus.draft,
  ),
  const InvoiceItemDisplayModel(
    id: '2024004',
    customer: 'Quantum Systems',
    dueDate: '01 Aug 2024',
    amount: 2100.00,
    status: InvoiceStatus.voided,
  ),
  const InvoiceItemDisplayModel(
    id: '2024005',
    customer: 'Stellar Technologies',
    dueDate: '18 Oct 2024',
    amount: 4200.00,
    status: InvoiceStatus.paid,
  ),
  const InvoiceItemDisplayModel(
    id: '2024006',
    customer: 'Nova Enterprises',
    dueDate: '22 Sep 2024',
    amount: 1800.00,
    status: InvoiceStatus.sent,
  ),
];
