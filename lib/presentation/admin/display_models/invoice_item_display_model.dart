import 'package:sync_pro/presentation/admin/display_models/customer_item_display_model.dart';
import 'package:sync_pro/presentation/admin/display_models/invoice_line_item_model.dart';

class InvoiceModel {
  final String id;
  final String invoiceDate;
  final String dueDate;
  final double amount;
  final String status;
  final CustomerModel customer;
  final List<InvoiceLineItemModel> lineItems;

  const InvoiceModel({
    required this.id,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.invoiceDate,
    required this.customer,
    required this.lineItems,
  });
}



