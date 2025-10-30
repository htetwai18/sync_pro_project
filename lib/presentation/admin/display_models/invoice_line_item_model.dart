import 'package:sync_pro/presentation/admin/display_models/invoice_item_display_model.dart';

class InvoiceLineItemModel {
  final String id;
  final String name;
  final int quantity;
  final double unitPrice;
  final InvoiceModel invoice;

  const InvoiceLineItemModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.invoice,
  });

  double get total => unitPrice * quantity;
}