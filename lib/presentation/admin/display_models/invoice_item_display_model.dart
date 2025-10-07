import 'package:sync_pro/config/enum.dart';

class InvoiceItemDisplayModel {
  final String id;
  final String customer;
  final String dueDate; // formatted
  final double amount;
  final InvoiceStatus status;
  // details
  final String invoiceDate;
  final List<InvoiceLineItem> items;
  final double taxPercent;

  const InvoiceItemDisplayModel({
    required this.id,
    required this.customer,
    required this.dueDate,
    required this.amount,
    required this.status,
    this.invoiceDate = '15 May 2024',
    this.items = const [],
    this.taxPercent = 0,
  });
}

class InvoiceLineItem {
  final String name;
  final int quantity;
  final double unitPrice;

  const InvoiceLineItem({
    required this.name,
    required this.quantity,
    required this.unitPrice,
  });

  double get total => unitPrice * quantity;
}

final List<InvoiceItemDisplayModel> mockInvoices = [
  const InvoiceItemDisplayModel(
    id: '2024001',
    customer: 'Tech Solutions Inc.',
    dueDate: '25 Aug 2024',
    amount: 1250.00,
    status: InvoiceStatus.paid,
    invoiceDate: '15 May 2024',
    items: [
      InvoiceLineItem(name: 'Consulting Services', quantity: 1, unitPrice: 500),
      InvoiceLineItem(
          name: 'Software Installation', quantity: 2, unitPrice: 200),
      InvoiceLineItem(name: 'Training Session', quantity: 1, unitPrice: 350),
    ],
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
